# frozen_string_literal: true

require 'rss'
require 'cgi'

module Changelog
  class RSS
    def self.create(path)
      new(path).write!
    end

    def initialize(path)
      @path = path
    end

    def write!
      rss = ::RSS::Maker.make("atom") do |maker|
        maker.channel.author = "GitLab Inc."
        maker.channel.updated = Time.now.to_s
        maker.channel.about = "https://about.gitlab.com/handbook/"
        maker.channel.title = "GitLab Handbook Changelog Feed"

        merge_requests.each do |mr|
          maker.items.new_item do |item|
            item.link = mr.link
            item.title = mr.title
            item.author = mr.author
            item.updated = mr.merged_at
            item.content.type = "html"
            item.content.content = mr.changes['changes'].map do |change|
              # Clean up some odd characters we see sometimes
              clean_diff = CGI.escapeHTML(change['diff'])
                            .gsub("\u0010", '\n') # An odd unicode char that seem to be meant to be interpreted as a newline
                            .delete(0x0C.chr) # Some 0x0C (FormFeed) chars show up occasionally, for some reason, and XML hates them.

              # A little post-processing to make the html more readable; uses the
              # same colors as the 'Changes' pane in the MR view for + and - lines.
              # There's likely more that could be done here, but the challenge is to keep it simple
              # e.g. I would be ware of trying to implement all the niceties of the MR changes view.
              lines = clean_diff.split("\n")
              lines = lines.map do |line|
                line = "<span style=\"background-color:#ddfbe6\">#{line}</span>" if line.start_with? "+"
                line = "<span style=\"background-color:#f9d7dc\">#{line}</span>" if line.start_with? "-"
                line
              end
              "<b>#{change['new_path']}</b>:<br>
               #{lines.join('<br>')}"
            end.join("<br><br>")
          end
        end
      end

      ::File.write(@path, rss)
    end

    private

    def merge_requests
      Gitlab
        .merge_requests(project_id, state: 'merged', order_by: 'updated_at')
        .paginate_with_limit(200)
        .map { |mr| MergeRequest.new(mr.iid, mr.title, mr.labels) }
        .select(&:changelog_entry?)
    end

    def project_id
      Changelog::WWW_GITLAB_COM_PROJECT_ID
    end
  end
end

module Gitlab
  class PaginatedResponse
    def paginate_with_limit(limit)
      response = block_given? ? nil : []
      count = 0
      each_page do |page|
        if block_given?
          page.each do |item|
            yield item
            count += 1
            break if count >= limit
          end
        else
          response += page[0, limit - count]
          count = response.length
        end
        break if count >= limit
      end
      response
    end
  end
end

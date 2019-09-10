# frozen_string_literal: true

module Changelog
  class MergeRequest
    NO_CHANGELOG_LABEL = "no changelog"

    attr_reader :iid, :title, :labels

    def initialize(mr)
      @iid = mr.iid
      @title = mr.title
      @labels = mr.labels || []
    end

    def changelog_entry?
      !labels.include?(NO_CHANGELOG_LABEL)
    end

    def date
      return DateTime.new(1970, 1, 1).to_date unless merged_at.is_a?(String)

      DateTime.parse(merged_at).to_date
    end

    def merged_at
      gitlab_merge_request.merged_at
    end

    def to_s
      "- [!#{iid}](#{link}) #{title}"
    end

    def link
      "https://git.dtone.xyz/office/handbook/merge_requests/#{iid}"
    end

    def author
      gitlab_merge_request.author.name
    end

    def changes
      return @changes if defined?(@changes)

      api_retry do
        @changes = Gitlab.merge_request_changes(Changelog::WWW_GITLAB_COM_PROJECT_ID, iid)&.to_h
      end

      @changes
    end

    private

    def gitlab_merge_request
      api_retry do
        @gitlab_merge_request ||= Gitlab.merge_request(Changelog::WWW_GITLAB_COM_PROJECT_ID, iid)
      end
      @gitlab_merge_request
    end

    # API calls can fail to connect occasionally, which really shouldn't be a reason to fail entirely
    # Give them 5 goes, just to get past any transient network fail
    def api_retry
      tries = 0
      begin
        yield
      rescue Net::OpenTimeout => error # There may be more errors we should catch
        retry if (tries += 1) < 5
        raise error
      end
    end
  end
end

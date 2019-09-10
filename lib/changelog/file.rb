# frozen_string_literal: true

module Changelog
  class File
    def self.create(path)
      new(path).write!
    end

    def initialize(path)
      @path = path
    end

    def write!
      content = <<~PREAMBLE
      ```eval_rst
      :orphan:
      ```
      # Handbook Changelog

      This changelog lists all merged merge-requests to `master` of the handbook.
        
      PREAMBLE

      content += merge_requests.group_by(&:date).map do |date, mrs|
        mrs.unshift("### #{date}").map(&:to_s).join("\n")
      end.join("\n\n")

      ::File.write(@path, content)
    end

    private

    DATE_SENTINEL = DateTime.new(2019, 9, 1)

    # This is a really expensive API call, as it will request all merge requests
    # that got created after DATE_SENTINEL.
    def merge_requests
      Gitlab
        .merge_requests(project_id, state: 'merged', created_after: DATE_SENTINEL.to_date.to_s)
        .auto_paginate
        .map do |mr|
        MergeRequest.new(mr)
      end.select(&:changelog_entry?)
    end

    def project_id
      Changelog::WWW_GITLAB_COM_PROJECT_ID
    end
  end
end

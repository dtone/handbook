# frozen_string_literal: true

require 'gitlab'
require 'date'

require_relative 'changelog/merge_request'
require_relative 'changelog/file'
require_relative 'changelog/rss'

Gitlab.configure do |config|
  config.endpoint = 'https://git.dtone.xyz/api/v4'
  config.private_token = ENV.fetch('GITLAB_PRIVATE_TOKEN', nil)
end

module Changelog
  WWW_GITLAB_COM_PROJECT_ID = 49
end

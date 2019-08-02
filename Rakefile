require 'yaml'
require 'stringex'
require 'time'
require 'middleman'

desc 'Run all lint tasks'
task lint: ['lint:scss',
           ] do
end

namespace :lint do
  desc 'Lint SCSS files'
  task :scss do
    cmd = "npx sass-lint -c .sass-lint.yml '**/*.scss' -v"
    raise "command failed: #{cmd.join(' ')}" unless system(cmd)
  end
end

desc 'Build the site in public/ (for deployment)'
task :build do
  build_cmd = %w[middleman build --bail]
  raise "command failed: #{build_cmd.join(' ')}" unless system(*build_cmd)
end


# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :rubocop do
  Dir.chdir(__dir__) { sh 'bundle exec rubocop' }
end

task default: %i[spec rubocop]

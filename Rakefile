#!/usr/bin/env rake
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
Bundler::GemHelper.install_tasks

# gem tasks
require 'bundler/gem_tasks'

# rake tasks
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/*_spec.rb']
end

# rubocop tasks
require 'rubocop/rake_task'
RuboCop::RakeTask.new

# cucumber tasks
require 'cucumber/rake/task'
Cucumber::Rake::Task.new

task default: [:rubocop, :spec, :cucumber]

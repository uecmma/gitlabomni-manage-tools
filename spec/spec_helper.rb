# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rspec'
require 'simplecov'

SimpleCov.start do
  add_filter '/vendor/'
  add_filter '/spec/'
  add_filter '/features/'

  add_group 'Commands', 'lib/gitlabomni_manage_tools/commands'
  add_group 'Utils', 'lib/gitlabomni_manage_tools/util'
end

require 'gitlabomni_manage_tools'

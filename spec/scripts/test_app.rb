#!/usr/bin/env ruby
# frozen_string_literal: true

require 'gitlabomni_manage_tools'
require_relative '../lib/testpkg'

GitLabOmnibusManage::Application.new(pkg: TestPkg).run

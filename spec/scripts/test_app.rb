#!/usr/bin/env ruby

require 'gitlabomni_manage_tools'
require_relative '../lib/testpkg'

GitLabOmnibusManage::Application.new(pkg: TestPkg).run

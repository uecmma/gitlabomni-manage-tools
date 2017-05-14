# frozen_string_literal: true

require 'thor'

require_relative 'util/archpkg'
require_relative 'config'

Dir.glob(
  File.expand_path('commands/*.rb', File.dirname(__FILE__))
).each do |entry|
  require_relative entry
end

module GitLabOmnibusManage
  class Command < Thor
    def initialize(args, opts, config)
      super(args, opts, config)

      return unless config[:current_command].disable_class_options.nil?

      @pkg = config[:package] || Util.gitlabpkg
      @config = Config.load(options['config'])
    end

    class_option :config, type: :string,
      banner: 'CONFIG', aliases: [:c],
      desc: 'use as global configuration'

    desc 'current-version', 'get current version'
    def current_version
      puts @pkg.current_version
    end

    desc 'available-version', 'get available version'
    def available_version
      puts @pkg.available_version
    end

    include GitLabOmnibusManage::SubCommands

    desc 'check', 'check updates'
    def check
      command_check
    end

    desc 'diff [options]', 'different from available'
    method_option :url, type: :boolean, default: false,
      desc: 'show URL based difference'
    def diff
      command_diff
    end

    desc 'notify-cronjob [options]', 'notify cron job command'
    method_option :mailto, type: :string,
      desc: 'address for mail to'
    method_option :force, type: :boolean, default: false,
      aliases: [:f], desc: 'force notification'
    def notify_cronjob
      command_notify_cronjob
    end
  end
end

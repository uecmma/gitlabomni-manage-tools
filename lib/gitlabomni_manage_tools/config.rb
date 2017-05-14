# frozen_string_literal: true

require 'yaml'
require 'socket'

require_relative 'util/base'

module GitLabOmnibusManage
  class Config
    class << self
      def load(path)
        config_obj = {}

        if path.nil?
          paths = default_paths
          config_obj = YAML.load_file(paths[0]) if paths.size.positive?
        else
          config_obj = YAML.load_file(path)
        end

        Config.new(config_obj)
      end

      def default_paths
        [
          '/etc/gitlab-manage/config.yaml',
          'config.yaml'
        ].select { |path| File.exist?(path) }
      end

      def default_config
        hostname = Util.hostfullname

        {
          'general' => {
            'data_dir' => '/var/lib/gitlab-manage/data',
            'cache_dir' => '/var/lib/gitlab-manage/cache'
          },
          'mail' => {
            'enable' => false,
            'host' => 'localhost',
            'port' => 25,
            'from' => "gitlab-manage@#{hostname}",
            'to' => "root@#{hostname}"
          }
        }
      end
    end

    def initialize(datas)
      datas = Util.deep_merge_hash(
        datas, Config.default_config
      )

      # general
      @data_dir = datas['general']['data_dir']
      @cache_dir = datas['general']['cache_dir']

      # mail
      @mail =
        if datas['mail']['enable']
          {
            host: datas['mail']['host'],
            port: datas['mail']['port'],
            from: datas['mail']['from'],
            to: datas['mail']['to'],
            show_diff: datas['mail']['show_diff']
          }
        end
    end

    # general
    attr_reader :data_dir
    attr_reader :cache_dir

    # mail
    def use_mail?
      !@mail.nil?
    end

    def mail_host
      @mail[:host]
    end

    def mail_port
      @mail[:port]
    end

    def mail_from
      @mail[:from]
    end

    def mail_to
      @mail[:to]
    end

    def mail_show_diff
      @mail[:show_diff]
    end
  end
end

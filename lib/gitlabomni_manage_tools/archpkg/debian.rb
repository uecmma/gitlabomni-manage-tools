# frozen_string_literal: true

module GitLabOmnibusManage
  module ArchPkg
    module DebianUtil
      module_function

      def apt_current_version(pkg)
        status = Hash[*`dpkg --status #{pkg}`
          .split(/\r?\n/)
          .flat_map { |line| line.split(': ', 2) }
        ]

        status['Version'].sub('-', '+')
      end

      def apt_available_version(pkg)
        status = Hash[*`apt-cache --quiet=0 show #{pkg}`
          .split(/\r?\n/)
          .slice_before(/^$/).first
          .flat_map { |line| line.split(': ', 2) }
        ]

        status['Version'].sub('-', '+')
      end
    end

    module Debian
      PKG_NAME = 'gitlab-ce'

      module_function

      def current_version
        DebianUtil.apt_current_version(PKG_NAME)
      end

      def available_version
        DebianUtil.apt_available_version(PKG_NAME)
      end

      def update_command
        <<~COMMAND
          apt-get install update
          apt-get install -y gitlab-ce
        COMMAND
          .strip
      end
    end

    module_function

    def debian
      Debian
    end
  end
end

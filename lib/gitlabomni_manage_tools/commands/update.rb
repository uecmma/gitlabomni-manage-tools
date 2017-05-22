# frozen_string_literal: true

require_relative '../util/base'

module GitLabOmnibusManage
  module SubCommands
    module UpdateCommand
      module_function

      def update_gitlab(pkg, options)
        pkg.update_command(
          quiet: options[:quiet],
          yes: options[:yes]
        ).split("\n").each do |command|
          system(command)
        end
      end

      def ask_edit_gitlab_conf
        ask_rest = GitLabOmnibusManage::Util.ask_yesno(
          'Edit GitLab config(`/etc/gitlab/gitlab.rb`)?',
          default: false
        )

        raise IllegalUserOperationError, 'type correctly' if ask_rest.nil?

        ask_rest
      end

      def edit_gitlab_conf(options)
        system(ENV['EDITOR'] || 'vi', '/etc/gitlab/gitlab.rb')
        `gitlab-ctl reconfigure#{ options[:quiet] ? ' > /dev/null' : '' }`
      end
    end

    def command_update
      current_ver = @pkg.current_version
      available_ver = @pkg.available_version

      if current_ver == available_ver
        puts 'up-to-date' unless options[:quiet]
        return
      end

      Lockfile(File.join(@config.cache_dir, 'update.lock')) do
        UpdateCommand.update_gitlab(@pkg, options)

        edit_gitlab_conf = !options[:yes]

        if edit_gitlab_conf
          edit_gitlab_conf = UpdateCommand.ask_edit_gitlab_conf
        end

        UpdateCommand.edit_gitlab_conf(options) if edit_gitlab_conf
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../util/base'

module GitLabOmnibusManage
  module SubCommands
    module UpdateIndexCommand
      module_function

      def update_index(pkg, options)
        pkg.update_index_command(
          quiet: options[:quiet]
        ).split("\n").each do |command|
          system(command)
        end
      end
    end

    def command_update_index
      UpdateIndexCommand.update_index(@pkg, options)
    end
  end
end

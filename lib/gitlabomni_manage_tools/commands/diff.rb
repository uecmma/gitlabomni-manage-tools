# frozen_string_literal: true

require_relative '../util/gitlabomni'

module GitLabOmnibusManage
  module SubCommands
    module DiffCommand
      module_function

      def diff_template(pkg)
        diff_output = GitLabOmnibusManage::Util.diff_gitlab_template(
          pkg.available_version
        )
        print diff_output
      end

      def diff_url(pkg)
        puts GitLabOmnibusManage::Util.diff_gitlab_url(
          pkg.current_version,
          pkg.available_version
        )
      end
    end

    def command_diff
      return if @pkg.current_version == @pkg.available_version

      if options[:url]
        DiffCommand.diff_url(@pkg)
      else
        DiffCommand.diff_template(@pkg)
      end
    end
  end
end

# frozen_string_literal: true

module GitLabOmnibusManage
  module SubCommands
    def command_check
      current_ver = @pkg.current_version
      available_ver = @pkg.available_version

      if current_ver == available_ver
        puts 'up-to-date'
      else
        puts <<~OUTPUT
          An update available: #{current_ver} -> #{available_ver}
        OUTPUT
      end
    end
  end
end

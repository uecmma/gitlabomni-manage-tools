# frozen_string_literal: true

require_relative 'command'

module GitLabOmnibusManage
  class Application
    def initialize(pkg: nil)
      @pkg = pkg
    end

    def run(argv = ARGV)
      config = {}
      config[:package] = @pkg unless @pkg.nil?

      Command.start(argv, config)
    end
  end

  module_function

  def application
    Application.new
  end
end

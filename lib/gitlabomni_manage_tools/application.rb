# frozen_string_literal: true

module GitLabOmnibusManage
  class Application
    def initialize
      puts 'initialized'
    end

    def run
      puts 'run application'
    end
  end

  def application
    Application.new
  end
  module_function :application
end

# frozen_string_literal: true

module TestPkg
  module_function

  def current_version
    '9.0.1+ce.0'
  end

  def available_version
    '9.0.2+ce.0'
  end

  def update_command
    <<~COMMAND
      yum install -y gitlab-ce
    COMMAND
      .strip
  end
end

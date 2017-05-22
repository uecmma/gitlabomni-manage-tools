# frozen_string_literal: true

module TestPkg
  module_function

  def current_version
    '9.0.1+ce.0'
  end

  def available_version
    '9.0.2+ce.0'
  end

  def update_command(hash = {})
    options = []
    hash.each do |k, v|
      options.push(k) if v
    end

    <<~COMMAND
      echo 'updating gitlab-ce'
      echo '  with [#{options.join(',')}] options'
    COMMAND
      .strip
  end
end

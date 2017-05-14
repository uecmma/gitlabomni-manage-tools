# frozen_string_literal: true

require 'open-uri'

module GitLabOmnibusManage
  module Util
    class GitLabInstallationError < StandardError; end

    module_function

    def get_gitlab_template(version)
      raw_url = [
        'https://gitlab.com/gitlab-org/omnibus-gitlab',
        "/raw/#{version}/files",
        '/gitlab-config-template/gitlab.rb.template'
      ].join('')

      open(raw_url, &:read)
    end

    def local_gitlab_template_path
      paths = [
        '/opt/gitlab/etc/gitlab.rb.template'
      ]

      paths.each do |path|
        return path if File.exist?(path)
      end

      raise GitLabInstallationError, 'gitlab template not found'
    end

    def diff_gitlab_template(version)
      online_template = get_gitlab_template(version)

      IO.popen("diff #{local_gitlab_template_path} -", 'r+') do |io|
        io.puts online_template
        io.close_write
        io.gets.to_s
      end
    end

    def diff_gitlab_url(from, to)
      format(
        'https://gitlab.com/gitlab-org/omnibus-gitlab/compare/%s...%s',
        from, to
      )
    end
  end
end

# frozen_string_literal: true

RSpec.describe GitLabOmnibusManage do
  describe 'running' do
    it 'is ok' do
      GitLabOmnibusManage.application.run
    end
  end
end

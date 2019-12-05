# frozen_string_literal: true

SingleCov.not_covered!

RSpec.describe 'Coverage' do
  it 'does not allow new untested code' do
    SingleCov.assert_used
  end

  it 'does not allow new untested files' do
    SingleCov.assert_tested untested: [
      'lib/notion_rb/version.rb'
    ]
  end
end

# frozen_string_literal: true

require 'notion_rb/operations/set_block_last_edited_time'
SingleCov.covered!

module NotionRb::Operations
  RSpec.describe SetBlockLastEditedTime do
    let(:id) { 'cb71f959-2f27-4756-a5d2-59b355cebef5' }
    let(:time) { DateTime.new }
    let(:opts) { {} }

    subject(:instance) { described_class.new(id, time, opts) }

    it_behaves_like 'an operation object'
  end
end

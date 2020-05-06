# frozen_string_literal: true

require 'notion_rb/operations/set_block_type'
SingleCov.covered!

module NotionRb::Operations
  RSpec.describe SetBlockType do
    let(:id) { 'cb71f959-2f27-4756-a5d2-59b355cebef5' }
    let(:type) { 'block' }

    subject(:instance) { described_class.new(id, type) }

    it_behaves_like 'an operation object'
  end
end

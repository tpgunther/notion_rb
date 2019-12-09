# frozen_string_literal: true

SingleCov.covered! # TODO: manually fix this

RSpec.describe NotionRb::Api::Block do
  context '#blocks' do
    it 'gets correct blocks', :vcr do
      block = NotionRb::Api::Block.new(notion_id: 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e')
      block.call
      expect(block.blocks[0].dig(:title)).to eq 'Testing notion gem'
    end
  end
end

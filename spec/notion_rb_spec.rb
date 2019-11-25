# frozen_string_literal: true

RSpec.describe NotionRb do
  it 'has a version number' do
    expect(NotionRb::VERSION).not_to be nil
  end

  it 'calls example file' do
    block = NotionRb::Api::Block.new(notion_id: "f0d7f6e4-c228-4cba-b860-a6f40ed3372e")
    block.call
    expect(block.blocks[0].dig(:title)).to eq 'Testing notion gem'
  end
end

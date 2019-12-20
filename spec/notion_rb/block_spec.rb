# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Block do
  let(:subject) { NotionRb::Block.new('https://www.notion.so/tpgunther/a-new-title-f0d7f6e4c2284cbab860a6f40ed3372e') }

  context '#title' do
    it 'gets correct title', :vcr do
      expect(subject.title).to eq 'Testing notion gem'
    end
  end

  context '#title=' do
    it 'sets correct title', :vcr do
      subject.title = 'A new title'
      expect(subject.title).to eq 'A new title'
    end
  end

  context '#parent' do
    let(:parent) { subject.parent }

    it 'gets parent', :vcr do
      expect(parent.instance_variable_get(:@uuid)).to eq subject.instance_variable_get(:@block)[:parent_id]
    end

    it 'has correct title', :vcr do
      expect(parent.title).to eq 'Inbox'
    end
  end
end

# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Utils::BlockCache do
  let(:subject) { NotionRb::Utils::BlockCache.instance }
  let!(:block_uuid) { '30e906ba-82c0-4a21-91fb-5bc21f65b3ef' }

  it 'is singleton' do
    expect(subject).to eq NotionRb::Utils::BlockCache.instance
  end

  context '#contains' do
    context 'empty' do
      it 'is false', :vcr do
        expect(subject.contains?(block_uuid)).to eq false
      end
    end

    context 'with blocks' do
      it 'is true', :vcr do
        subject.send(:add_block, block_uuid)
        expect(subject.contains?(block_uuid)).to eq true
      end
    end
  end

  context '#find' do
    context 'existing block' do
      it 'gets blocks', :vcr do
        expect(subject.find(block_uuid)[:notion_id]).to eq block_uuid
      end
    end

    context 'non-existing block' do
      it 'returns nil', :vcr do
        expect(subject.find('non-existing-block')).to eq nil
      end
    end
  end

  context '#children' do
    context 'existing block' do
      it 'gets children blocks', :vcr do
        expect(subject.children(block_uuid)).to eq %w[36e0e58b-7459-4dba-88c2-e28100411d7f 4737e75b-76e7-43cf-8bec-cc71892ae7c0]
      end
    end

    context 'non-existing block' do
      it 'returns nil', :vcr do
        expect(subject.children('non-existing-block')).to eq nil
      end
    end
  end

  context '#clear' do
    it 'clears blocks', :vcr do
      subject.find(block_uuid)[:notion_id]
      subject.clear
      expect(subject.contains?(block_uuid)).to eq false
    end
  end

  context '#add_blocks' do
    it 'gets blocks', :vcr do
      block = subject.send(:add_block, block_uuid)[0]
      expect(block[:notion_id]).to eq block_uuid
    end
  end
end

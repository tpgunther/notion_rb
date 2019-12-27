# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Utils::BlockCache do
  let(:subject) { NotionRb::Utils::BlockCache.instance }
  let!(:block) { FactoryBot.json(:block, :text) }

  it 'is singleton' do
    expect(subject).to eq NotionRb::Utils::BlockCache.instance
  end

  context 'with blocks' do
    before do
      subject.add_blocks([block])
      subject.add_blocks([FactoryBot.json(:block, :text)])
    end

    context '#contains?' do
      it 'returns true' do
        expect(subject.contains?(block[:notion_id])).to eq true
      end

      context '#find' do
        it 'returns block' do
          expect(subject.find(block[:notion_id])).to eq block
        end
      end

      context '#clear' do
        it 'clears blocks' do
          subject.clear
          expect(subject.find(block[:notion_id])).to eq nil
        end
      end

      context 'add an existing block with new content' do
        let(:new_block) { block.dup }

        before do
          new_block[:title] += ' more content'
          subject.add_blocks([new_block])
        end

        it 'updates new content to cache' do
          expect(subject.find(block[:notion_id])[:title]).to eq new_block[:title]
        end
      end
    end
  end

  context 'without block' do
    context '#contains?' do
      it 'returns false' do
        expect(subject.contains?(block[:notion_id])).to eq false
      end

      context '#find' do
        it 'returns nil' do
          expect(subject.find(block[:notion_id])).to eq nil
        end
      end

      context '#clear' do
        it 'clears blocks' do
          subject.clear
          expect(subject.find(block[:notion_id])).to eq nil
        end
      end
    end
  end
end

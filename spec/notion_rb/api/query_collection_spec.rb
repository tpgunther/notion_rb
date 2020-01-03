# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Api::QueryCollection do
  context 'with existing page' do
    let(:subject) { NotionRb::Api::QueryCollection.new(collection_id: '1f564fea-8711-480c-9cb8-9d56ce5beb68', view_id: 'e9c7a91e-b4dd-4eb4-9418-0957c2d1444b') }

    context '#success?' do
      it 'is true', :vcr do
        expect(subject.success?).to eq true
      end
    end

    context '#call' do
      it 'does not raise', :vcr do
        expect { subject.call }.not_to raise_error
      end
    end
  end

  context 'with non-existing page' do
    let(:subject) { NotionRb::Api::QueryCollection.new(notion_id: '404-page') }

    context '#success?' do
      it 'is false', :vcr do
        expect(subject.success?).to eq false
      end
    end

    context '#call' do
      it 'raises 400', :vcr do
        expect { subject.call }.to raise_error Mechanize::ResponseCodeError, /400/
      end
    end
  end
end

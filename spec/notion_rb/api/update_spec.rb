# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Api::Update do
  context 'with existing page' do
    let(:subject) { NotionRb::Api::Update.new(notion_id: 'b4902cb0-62da-42cc-bb1a-1e6c57c62feb', title: 'A new title 2') }

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
    let(:subject) { NotionRb::Api::Update.new(notion_id: '404-page', title: 'A new title 2') }

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

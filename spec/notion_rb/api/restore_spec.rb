# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Api::Restore do
  context 'with existing page' do
    let(:subject) { NotionRb::Api::Restore.new(notion_id: 'a77e7a3a-6fda-40c0-a4a2-562990b9b272', parent_id: 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e') }

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
    let(:subject) { NotionRb::Api::Restore.new(notion_id: '404-page') }

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

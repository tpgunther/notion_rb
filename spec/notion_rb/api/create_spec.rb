# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Api::Create do
  context 'with existing parent page' do
    let(:subject) { NotionRb::Api::Create.new(parent_id: 'b4902cb0-62da-42cc-bb1a-1e6c57c62feb') }

    context '#success?' do
      it 'is true', :vcr do
        expect(subject.success?).to eq true
      end
    end

    context '#block_uuid' do
      it 'is correct', :vcr do
        expect(subject.block_uuid.class).to eq String
      end
    end

    context '#call' do
      it 'does not raise', :vcr do
        expect { subject.call }.not_to raise_error
      end
    end
  end

  context 'with non-existing parent page' do
    let(:subject) { NotionRb::Api::Create.new(parent_id: '404-page') }

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

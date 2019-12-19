# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Api::Get do
  subject { NotionRb::Api::Get.new(notion_id: 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e') }

  context '#response' do
    context 'success request' do
      it 'has 200 status', :vcr do
        expect(subject.success?).to eq true
      end
    end

    context 'non existing page' do
      subject { NotionRb::Api::Get.new(notion_id: 'non-existing-id') }

      it 'raises response code error 400', :vcr do
        expect { subject.send(:response) }.to raise_error Mechanize::ResponseCodeError, /400/
      end
    end

    context 'unexpected server error' do
      subject { NotionRb::Api::Get.new(notion_id: 'other-id') }

      it 'raises response code error 500', :vcr do
        expect { subject.send(:response) }.to raise_error Mechanize::ResponseCodeError, /500/
      end
    end
  end

  context '#blocks' do
    it 'gets correct blocks', :vcr do
      expect(subject.blocks[0].dig(:title)).to eq 'Testing notion gem'
    end

    it 'requests only once', :vcr do
      expect(subject.blocks).to eq subject.blocks
    end
  end
end

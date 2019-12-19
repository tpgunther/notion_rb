# frozen_string_literal: false

class DummyClass
  include NotionRb::UuidValidator
end

SingleCov.covered!

RSpec.describe NotionRb::UuidValidator, type: :module do
  let(:subject) { DummyClass.new }

  context '#parse_from_hex' do
    context 'with correct size' do
      it 'parses correct ' do
        hex = '1234567890abcdef1234567890abcdef'
        expect(subject.parse_from_hex(hex)).to eq '12345678-90ab-cdef-1234-567890abcdef'
      end
    end

    context 'with incorrect size' do
      it 'raises error' do
        hex = '123456'
        expect { subject.parse_from_hex(hex) }.to raise_error ArgumentError, /Incorrect hex size/
      end
    end
  end

  context '#parse_from_url' do
    context 'with url' do
      it 'returns hex' do
        url = 'https://www.notion.so/someone/Testing-notion-gem-f0d7f6e4c2284cbab860a6f40ed3372e'
        expect(subject.parse_from_url(url)).to eq 'f0d7f6e4c2284cbab860a6f40ed3372e'
      end
    end

    context 'with hex' do
      it 'returns hex' do
        url = 'f0d7f6e4c2284cbab860a6f40ed3372e'
        expect(subject.parse_from_url(url)).to eq 'f0d7f6e4c2284cbab860a6f40ed3372e'
      end
    end
  end

  context '#parse_uuid' do
    context 'with url' do
      it 'returns uuid' do
        url = 'https://www.notion.so/someone/Testing-notion-gem-f0d7f6e4c2284cbab860a6f40ed3372e'
        expect(subject.parse_uuid(url)).to eq 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e'
      end
    end

    context 'with url with params' do
      it 'returns uuid' do
        url = 'https://www.notion.so/someone/Testing-notion-gem-f0d7f6e4c2284cbab860a6f40ed3372e?a=1'
        expect(subject.parse_uuid(url)).to eq 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e'
      end
    end

    context 'with hex' do
      it 'returns uuid' do
        url = 'f0d7f6e4c2284cbab860a6f40ed3372e'
        expect(subject.parse_uuid(url)).to eq 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e'
      end
    end

    context 'with uuid' do
      it 'returns uuid' do
        url = 'f0d7f6e4-c228-4cba-b860-a6f4-0ed3372e'
        expect(subject.parse_uuid(url)).to eq 'f0d7f6e4-c228-4cba-b860-a6f40ed3372e'
      end
    end

    context 'with incorrect size' do
      it 'raises error' do
        url = 'f0d7f6e4-c228-4cba-b860-a6f4-0ed3372'
        expect { subject.parse_uuid(url) }.to raise_error ArgumentError, /Incorrect hex size/
      end

      it 'raises error' do
        url = 'https://www.notion.so/someone/Testing-notion-gem-f0d7f6e4c2284cbab860a6f40'
        expect { subject.parse_uuid(url) }.to raise_error ArgumentError, /Incorrect hex size/
      end
    end
  end
end

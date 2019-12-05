# frozen_string_literal: true

RSpec.describe NotionRb::Utils::Converter do
  let(:value) { FactoryBot.json(:notion_value, :text) }

  context '#convert' do
    it 'generates correct positions' do
      expect(subject.send(:convert, value)[:position]).to eq 0
      expect(subject.send(:convert, value)[:position]).to eq 1
      expect(subject.send(:convert, value)[:position]).to eq 2
    end

    it 'generates correct title' do
      expect(subject.send(:convert, value)[:title]).to eq value[:properties][:title][0][0]
    end
  end

  context '#parse' do
    context 'with correct type' do
      before do
        @result = subject.send(:parse, value)
      end

      it 'generates correct title' do
        expect(@result[:title]).to eq value[:properties][:title][0][0]
      end

      it 'generates correct parent' do
        expect(@result[:parent_id]).to eq value[:parent_id]
      end
    end

    context 'with incorrect type' do
      before do
        value[:type] = 'invalid_block'
      end

      it 'raises exception' do
        expect { subject.send(:parse, value) }.to raise_error ArgumentError
      end
    end
  end
end

# frozen_string_literal: true

RSpec.describe NotionRb::Utils::Parser do
  subject { NotionRb::Utils::Parser.new(value, 0) }

  context '#null' do
    let(:value) { FactoryBot.json(:notion_value, :divider) }

    it 'generates correct hash' do
      expect(subject.null).to eq({})
    end
  end

  context '#base' do
    let(:value) { FactoryBot.json(:notion_value, :page) }

    it 'generates correct hash' do
      expect(subject.base).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0
      )
    end
  end

  context '#text' do
    let(:value) { FactoryBot.json(:notion_value, :text) }

    it 'generates correct hash' do
      expect(subject.text).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        title: value['properties']['title'][0][0]
      )
    end
  end

  context '#todo' do
    let(:value) { FactoryBot.json(:notion_value, :todo) }

    it 'generates correct hash' do
      expect(subject.todo).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        title: value['properties']['title'][0][0],
        metadata: {
          checked: true
        }
      )
    end
  end

  context '#code' do
    let(:value) { FactoryBot.json(:notion_value, :code) }

    it 'generates correct hash' do
      expect(subject.code).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        title: value['properties']['title'][0][0],
        metadata: {
          language: value['properties']['language'][0][0]
        }
      )
    end
  end

  context '#embed' do
    let(:value) { FactoryBot.json(:notion_value, :embed) }

    it 'generates correct hash' do
      expect(subject.embed).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        title: value['properties']['title'][0][0],
        metadata: {
          source: value['properties']['source'][0][0]
        }
      )
    end
  end

  context '#bookmark' do
    let(:value) { FactoryBot.json(:notion_value, :bookmark) }

    it 'generates correct hash' do
      expect(subject.bookmark).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        title: value['properties']['title'][0][0],
        metadata: {
          source: value['properties']['link'][0][0]
        }
      )
    end
  end
end

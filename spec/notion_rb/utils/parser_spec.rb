# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Utils::Parser do
  subject { NotionRb::Utils::Parser.new(value, 0) }

  context 'invalid type' do
    let(:value) { FactoryBot.json(:notion_value, :invalid) }

    it 'raises error' do
      expect { subject.parse }.to raise_error ArgumentError, /Invalid block type/
    end
  end

  context 'null parse' do
    let(:value) { FactoryBot.json(:notion_value, :table_of_contents) }

    it 'generates correct hash' do
      expect(subject.parse).to eq({})
    end
  end

  context 'base parser' do
    context 'page block' do
      let(:value) { FactoryBot.json(:notion_value, :page) }

      it 'generates correct hash' do
        expect(subject.parse).to eq(
          notion_id: value['id'],
          block_type: value['type'],
          parent_id: value['parent_id'],
          position: 0,
          children: value['content'],
          title: value['properties']['title'][0][0],
          metadata: {
            color: 'black',
            block_color: 'white',
            properties: { 'title' => [['Test title']] }
          }
        )
      end
    end

    context 'text block' do
      let(:value) { FactoryBot.json(:notion_value, :text) }

      it 'generates correct hash' do
        expect(subject.parse).to eq(
          notion_id: value['id'],
          block_type: value['type'],
          parent_id: value['parent_id'],
          position: 0,
          children: [],
          title: value['properties']['title'][0][0],
          metadata: {
            color: 'black',
            block_color: 'white',
            properties: { 'title' => [['Test title']] }
          }
        )
      end
    end
  end

  context 'todo parser' do
    let(:value) { FactoryBot.json(:notion_value, :todo) }

    it 'generates correct hash' do
      expect(subject.parse).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        children: [],
        title: value['properties']['title'][0][0],
        metadata: {
          color: 'black',
          block_color: 'white',
          properties: { 'checked' => [['Yes']], 'title' => [['Todo title']] },
          checked: true
        }
      )
    end
  end

  context 'code parser' do
    let(:value) { FactoryBot.json(:notion_value, :code) }

    it 'generates correct hash' do
      expect(subject.parse).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        children: [],
        title: value['properties']['title'][0][0],
        metadata: {
          color: 'black',
          block_color: 'white',
          properties: { 'language' => [['ruby']], 'title' => [['Code']] },
          language: value['properties']['language'][0][0]
        }
      )
    end
  end

  context 'embed parser' do
    let(:value) { FactoryBot.json(:notion_value, :embed) }

    it 'generates correct hash' do
      expect(subject.parse).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        children: [],
        title: value['properties']['title'][0][0],
        metadata: {
          color: 'black',
          block_color: 'white',
          properties: { 'source' => [['https://www.github.com']], 'title' => [['Embed title']] },
          source: value['properties']['source'][0][0]
        }
      )
    end
  end

  context 'bookmark parser' do
    let(:value) { FactoryBot.json(:notion_value, :bookmark) }

    it 'generates correct hash' do
      expect(subject.parse).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        children: [],
        title: value['properties']['title'][0][0],
        metadata: {
          color: 'black',
          block_color: 'white',
          properties: { 'link' => [['https://www.github.com']], 'title' => [['Bookmark title']] },
          source: value['properties']['link'][0][0]
        }
      )
    end
  end

  context 'callout parser' do
    let(:value) { FactoryBot.json(:notion_value, :callout) }

    it 'generates correct hash' do
      expect(subject.parse).to eq(
        notion_id: value['id'],
        block_type: value['type'],
        parent_id: value['parent_id'],
        position: 0,
        children: [],
        title: value['properties']['title'][0][0],
        metadata: {
          color: 'black',
          block_color: 'white',
          properties: { 'title' => [['Test title']] },
          page_icon: value.dig('format', 'page_icon')
        }
      )
    end
  end
end

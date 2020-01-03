# frozen_string_literal: true

SingleCov.covered!

RSpec.describe NotionRb::Block do
  let(:subject) { NotionRb::Block.new('https://www.notion.so/tpgunther/a-new-title-f0d7f6e4c2284cbab860a6f40ed3372e') }

  after(:each) do
    NotionRb::Utils::BlockCache.instance.clear
  end

  context '#title' do
    it 'gets correct title', :vcr do
      expect(subject.title).to eq 'Testing notion gem'
    end
  end

  context '#title=' do
    it 'sets correct title', :vcr do
      subject.title = 'A new title'
      expect(subject.title).to eq 'A new title'
    end
  end

  context '#type' do
    it 'gets correct type', :vcr do
      expect(subject.type).to eq 'page'
    end
  end

  context '#type=' do
    context 'with invalid type' do
      it 'does not set type', :vcr do
        subject.type = 'non-type'
        expect(subject.type).to eq 'page'
      end
    end

    context 'with valid type' do
      it 'sets correct type', :vcr do
        subject.type = 'toggle'
        expect(subject.type).to eq 'toggle'
      end
    end
  end

  context '#parent' do
    let(:parent) { subject.parent }

    it 'gets parent', :vcr do
      expect(parent.instance_variable_get(:@uuid)).to eq subject.instance_variable_get(:@block)[:parent_id]
    end

    it 'has correct title', :vcr do
      expect(parent.title).to eq 'Inbox'
    end
  end

  context '#children' do
    it 'gets correct children uuid', :vcr do
      expect(subject.children[0].parent.instance_variable_get(:@uuid)).to eq subject.instance_variable_get(:@uuid)
    end

    it "gets children's children", :vcr do
      expect(subject.children[0].title).to eq 'Header 1'
      expect(subject.children[-3].children[0].title).to eq 'Child 1'
    end
  end

  context 'collection_view' do
    let(:subject) { NotionRb::Block.new('0bfbf00d8e7942e5858d2a60f1e20687') }

    context '#children' do
      it 'gets collection children', :vcr do
        expect(subject.children.count).to eq 1
      end

      it 'gets correct type', :vcr do
        expect(subject.children.first.type).to eq 'collection'
      end

      it 'gets correct rows count', :vcr do
        expect(subject.children.first.children.count).to eq 3
      end

      it 'gets correct rows name', :vcr do
        expect(subject.children.first.children.first.title).to eq 'A new name'
      end
    end
  end

  context '#metadata' do
    let(:subject) { NotionRb::Block.new('30e906ba82c04a2191fb5bc21f65b3ef') }

    it 'gets parents name properties', :vcr do
      expect(subject.metadata.key?('Tags')).to eq true
    end

    it 'gets properties', :vcr do
      expect(subject.metadata['Tags']).to eq 'new tag'
    end
  end

  context 'destroy and restore' do
    before do
      @subject = NotionRb::Block.new('13f5a83a5a6f4625a87644cae16b9648')
    end

    context '#destroy' do
      it 'is destroyed', :vcr do
        expect(@subject.destroy).to eq true
      end
    end

    context '#restore' do
      it 'is restored', :vcr do
        expect(@subject.restore).to eq true
      end
    end
  end
end

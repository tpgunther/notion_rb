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

  context 'create and destroy' do
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

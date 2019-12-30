# encoding: utf-8

class DummyClass
  include NotionRb::Utils::Types
end

SingleCov.covered!

RSpec.describe NotionRb::Utils::Types do
  let(:subject) { DummyClass.new }

  context "#valid_block_type?" do
    context "existing block" do
      it 'returns true' do
        expect(subject.valid_block_type?('header')).to eq true
      end
    end

    context "invalid block" do
      it 'returns false' do
        expect(subject.valid_block_type?('non-block')).to eq false
      end
    end
  end
end

# frozen_string_literal: true

SingleCov.covered!

module NotionRb
  RSpec.describe Transaction do
    subject(:instance) { described_class.new }

    describe '#to_h' do
      subject { instance.to_h }

      context 'with operations added' do
        let(:block_id) { '1234556' }
        before do
          instance.add_operation(:set_block_type, block_id, 'text')
        end

        it 'returns the transaction as a hash for execution' do
          is_expected.to match(
            id: a_string_matching(/[a-f0-9\-]*/),
            operations: [
              {
                id: block_id,
                table: 'block',
                path: [],
                command: 'set',
                args: { type: 'text', id: block_id, version: 1 }
              }
            ]
          )
        end
      end
    end
  end
end

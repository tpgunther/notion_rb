# frozen_string_literal: true

SingleCov.covered!

module NotionRb
  RSpec.describe Transaction do
    subject(:instance) { described_class.new }

    describe '#to_h' do
      subject { instance.to_h }

      context 'with operations added' do
        let(:block_id) { '1234556' }
        let(:parent_id) { '789' }
        let(:created_time) { (Time.now.to_i / 100) * 100_000 }
        before do
          instance.add_operation(:set_block_type, block_id, 'text')
          instance.add_operation(:update_parent, block_id, parent_id)
          instance.add_operation(:list_after, parent_id, block_id)
          instance.add_operation(:set_block_title, block_id)
          instance.add_operation(:set_block_created_time, block_id,
                                 created_time)
          instance.add_operation(:set_block_last_edited_time, block_id,
                                 created_time)
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
              },
              {
                id: block_id,
                table: 'block',
                path: [],
                command: 'update',
                args: { parent_id: parent_id, parent_table: 'block',
                        alive: true }
              }, {
                id: parent_id,
                table: 'block',
                path: ['content'],
                command: 'listAfter',
                args: { id: block_id }
              }, {
                id: block_id,
                table: 'block',
                path: %w[
                  properties
                  title
                ],
                command: 'set',
                args: []
              }, {
                id: block_id,
                table: 'block',
                path: ['created_time'],
                command: 'set',
                args: created_time
              }, {
                id: block_id,
                table: 'block',
                path: ['last_edited_time'],
                command: 'set',
                args: created_time
              }
            ]
          )
        end
      end
    end
  end
end

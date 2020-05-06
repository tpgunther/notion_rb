# frozen_string_literal: true

SingleCov.covered!

module NotionRb::Operations
  RSpec.describe Factory do
    subject(:instance) { described_class.new }

    describe '.build' do
      context 'when passed an operation name and operation args' do
        let(:args) { [] }
        subject { described_class.build(operation_name, *args) }
        context 'and the operation name is valid' do
          let(:operation_name) { :list_after }
          let(:args) { ['id-1', 'id-2'] }

          it 'initializes the proper operation with the args' do
            expect(ListAfter).to receive(:new).with(*args)
            subject
          end
        end

        context 'and the operation name is not valid' do
          let(:operation_name) { :cat }

          it 'raises a KeyError' do
            expect { subject }.to raise_error(KeyError)
          end
        end
      end
    end
  end
end

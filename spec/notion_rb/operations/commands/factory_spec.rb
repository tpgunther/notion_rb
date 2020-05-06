# frozen_string_literal: true

SingleCov.covered!

module NotionRb::Operations::Commands
  RSpec.describe Factory do
    subject(:instance) { described_class.new }

    describe '.build' do
      context 'when passed a command name, primary notion id, and opts args' do
        subject { described_class.build(command_name, notion_id, opts) }
        let(:notion_id) { 'id-1' }
        let(:opts) { {} }

        context 'and the command name is valid' do
          let(:command_name) { :set }

          it 'initializes the proper command with the args' do
            expect(Set).to receive(:new).with(notion_id, {})
            subject
          end
        end

        context 'and the command name is not valid' do
          let(:command_name) { :cat }

          it 'raises a KeyError' do
            expect { subject }.to raise_error(KeyError)
          end
        end
      end
    end
  end
end

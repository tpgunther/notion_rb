# frozen_string_literal: true
require 'notion_rb/operations/commands/base'
SingleCov.covered!

module NotionRb::Operations::Commands
  RSpec.describe Base do
    let(:id) { '8de6cf7c-2cbd-40e6-9ee0-6a139ffa1523' }
    let(:command) { 'sample-command' }
    let(:opts) { { command: command } }
    let(:table) { 'block' }
    let(:args) { 'args' }
    let(:path) { 'path' }
    subject(:instance) { described_class.new(id, opts) }

    context 'when initialized with an id and opts hash' do
      context 'and opts hash does not have a :command key' do
        let(:opts) { {} }

        it 'raises an ArgumentError' do
          expect { instance }.to raise_error ArgumentError
        end
      end

      context 'and the opts hash commands a command key' do
        it 'sets the command and id properly' do
          expect(instance.id).to eq id
          expect(instance.command).to eq command
        end
      end

      context 'and opts contanins other valid keys' do
        let(:opts) do
          {
            command: command,
            table: table,
            path: path,
            args: args
          }
        end

        it 'sets those attributes properly' do
          expect(instance.table).to eq table
          expect(instance.args).to eq args
          expect(instance.path).to eq path
        end
      end
    end

    describe '#to_h' do
      subject { instance.to_h }
      let(:opts) do
        {
          command: command,
          table: table,
          path: path,
          args: args
        }
      end

      it 'returns the attributes of the command as a serializable hash' do
        is_expected.to match(
          id: id,
          table: table,
          path: path,
          command: command,
          args: args
        )
      end
    end
  end
end

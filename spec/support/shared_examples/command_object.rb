# frozen_string_literal: true

RSpec.shared_examples 'a command object' do
  let(:id) { '4461b1c2-dac2-4908-bb17-cb7c02133067' }
  let(:command_key) { 'set' }
  let(:opts) { { command: command_key } }

  subject(:instance) { described_class.new(id, opts) }

  describe '#to_h' do
    subject { instance.to_h }

    it 'returns a hash containing the id and the correct command' do
      is_expected.to be_a Hash
      expect(subject[:id]).to eq id
      expect(subject[:command]).to eq described_class::COMMAND
    end
  end
end

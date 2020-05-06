# frozen_string_literal: true

RSpec.shared_examples 'an operation object' do
  describe '#commands' do
    subject { instance.commands }

    it 'returns an array of command objects' do
      is_expected.to be_an Array
      is_expected.not_to be_empty
      is_expected.to all(be_a NotionRb::Operations::Commands::Base)
    end
  end
end

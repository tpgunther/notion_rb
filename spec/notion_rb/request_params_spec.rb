# frozen_string_literal: true

SingleCov.covered!

module NotionRb
  RSpec.describe RequestParams do
    subject(:instance) { described_class.new }

    describe '#add_transaction' do
      subject { instance.add_transaction }

      it { is_expected.to be_a Transaction }

      it 'adds the returned transaction to its transactions' do
        expect { subject }
          .to change(instance.transactions, :count).by(1)

        expect(instance.transactions).to include(subject)
      end
    end

    describe '#to_h' do
      subject { instance.to_h }

      let(:t_as_h) { { a: :b } }
      let(:t2_as_h) { { a: :c } }
      let(:transaction) { double('transaction', to_h: t_as_h) }
      let(:transaction_2) { double('transaction', to_h: t2_as_h) }

      before do
        expect(Transaction).to receive(:new).and_return(transaction)
        expect(Transaction).to receive(:new).and_return(transaction_2)
        2.times { instance.add_transaction }
      end

      it 'returns a hash containing its request_id and transactions' do
        is_expected.to match(
          requestId: a_string_matching(/[a-f0-9\-]*/),
          transactions: [t_as_h, t2_as_h]
        )
      end
    end
  end
end

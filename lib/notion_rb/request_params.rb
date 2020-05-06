# frozen_string_literal: true

module NotionRb
  class RequestParams
    attr_reader :transactions, :request_id

    def initialize
      @request_id = SecureRandom.uuid
      @transactions = []
    end

    def add_transaction
      Transaction.new.tap { |t| @transactions.push(t) }
    end

    def to_h
      {
        requestId: request_id,
        transactions: transactions.map(&:to_h)
      }
    end
  end
end

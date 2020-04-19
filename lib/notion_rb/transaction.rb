# frozen_string_literal: true

module NotionRb
  class Transaction
    attr_reader :id, :operations

    def initialize
      @id = SecureRandom.uuid
      @operations = []
    end

    def add_operation(operation_name, *args)
      operations.push(
        Operations::Factory.build(operation_name, *args)
      )
      self
    end

    def to_h
      { id: id, operations: operations.flat_map { |o| o.commands.map(&:to_h) } }
    end
  end
end

# frozen_string_literal: true

require_relative './set_block_type'

module NotionRb
  module Operations
    class Factory
      OPERATIONS = Hash[
        [
          SetBlockType
        ].map { |klass| [klass::OPERATION_NAME, klass] }
      ]

      def self.build(operation_name, *args)
        OPERATIONS.fetch(operation_name).new(
          *args
        )
      end
    end
  end
end

# frozen_string_literal: true

require_relative './set_block_type'
require_relative './set_block_last_edited_time'
require_relative './set_block_created_time'
require_relative './set_block_title'
require_relative './list_after'
module NotionRb
  module Operations
    class Factory
      OPERATIONS = Hash[
        [
          ListAfter,
          SetBlockCreatedTime,
          SetBlockLastEditedTime,
          SetBlockTitle,
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

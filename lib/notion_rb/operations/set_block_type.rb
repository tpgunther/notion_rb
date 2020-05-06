# frozen_string_literal: true

module NotionRb
  module Operations
    class SetBlockType
      DEFAULT_VERSION = 1
      COMMAND_TYPE = :set
      OPERATION_NAME = :set_block_type
      TABLE = 'block'

      attr_reader :id, :type

      def initialize(id, type)
        @id = id
        @type = type
      end

      def commands
        [
          Commands::Factory.build(
            :set,
            id,
            args: args,
            table: TABLE
          )
        ]
      end

      def args
        {
          type: type,
          version: DEFAULT_VERSION,
          id: id
        }
      end
    end
  end
end

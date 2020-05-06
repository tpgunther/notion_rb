# frozen_string_literal: true

module NotionRb
  module Operations
    class UpdateParent
      COMMAND_TYPE = :update
      OPERATION_NAME = :update_parent
      TABLE = 'block'
      DEFAULT_PARENT_TABLE = TABLE
      DEFAULT_ALIVE_VALUE = true

      attr_reader :id, :parent_id, :parent_table, :alive

      def initialize(id, parent_id, opts = {})
        @id = id
        @parent_id = parent_id
        @parent_table = opts.fetch(:parent_table, DEFAULT_PARENT_TABLE)
        @alive = opts.fetch(:alive, DEFAULT_ALIVE_VALUE)
      end

      def commands
        [
          Commands::Factory.build(
            COMMAND_TYPE,
            id,
            args: args,
            table: TABLE
          )
        ]
      end

      def args
        {
          parent_id: parent_id,
          parent_table: parent_table,
          alive: alive
        }
      end
    end
  end
end

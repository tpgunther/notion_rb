# frozen_string_literal: true

module NotionRb
  module Operations
    class ListAfter
      COMMAND_TYPE = :list_after
      OPERATION_NAME = :list_after
      DEFAULT_TABLE = 'block'
      DEFAULT_PATH = ['content']

      attr_reader :id, :list_after_id, :table, :path

      def initialize(id, list_after_id, opts={})
        @id = id
        @list_after_id = list_after_id
        @table = opts.fetch(:table, DEFAULT_TABLE)
        @path = opts.fetch(:path, DEFAULT_PATH)
      end

      def commands
        [
          Commands::Factory.build(
            COMMAND_TYPE,
            id,
            args: args,
            table: table,
            path: path
          )
        ]
      end

      def args
        {
          id: list_after_id
        }
      end
    end
  end
end

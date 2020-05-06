# frozen_string_literal: true

module NotionRb
  module Operations
    class SetBlockLastEditedTime
      COMMAND_TYPE = :set
      OPERATION_NAME = :set_block_last_edited_time
      DEFAULT_PATH = ['last_edited_time'].freeze
      TABLE = 'block'

      attr_reader :id, :time, :path

      def initialize(id, time, opts = {})
        @id = id
        @time = time
        @path = opts.fetch(:path, DEFAULT_PATH)
      end

      def commands
        [
          Commands::Factory.build(
            COMMAND_TYPE,
            id,
            args: args,
            table: TABLE,
            path: path
          )
        ]
      end

      def args
        time
      end
    end
  end
end

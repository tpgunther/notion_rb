# frozen_string_literal: true

module NotionRb
  module Operations
    class SetBlockTitle
      COMMAND_TYPE = :set
      OPERATION_NAME = :set_block_title
      TABLE = 'block'
      DEFAULT_PATH = %w[properties title].freeze

      attr_reader :id, :title, :path

      def initialize(id, title = nil, opts = {})
        @id = id
        @title = title
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
        return [] if title.nil?
      end
    end
  end
end

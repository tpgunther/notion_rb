# frozen_string_literal: true

module NotionRb
  module Operations
    class SetBlockCreatedTime < SetBlockLastEditedTime
      OPERATION_NAME = :set_block_created_time
      DEFAULT_PATH = ['created_time'].freeze

      def initialize(id, time, opts = {})
        opts[:path] ||= DEFAULT_PATH
        super
      end
    end
  end
end

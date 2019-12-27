# frozen_string_literal: true

module NotionRb
  module Api
    class Update < Base
      def initialize(params)
        super

        @title = params[:title]
        @block_type = params[:block_type]
      end

      private

      def url
        "#{API_BASE_URL}submitTransaction"
      end

      def params
        {
          requestId: SecureRandom.uuid,
          transactions: [{
            id: SecureRandom.uuid,
            operations: [{
              id: @notion_id,
              table: 'block',
              path: %w[properties title],
              command: 'set',
              args: [[@title]]
            }]
          }, {
            id: SecureRandom.uuid,
            operations: [{
              id: @notion_id,
              table: 'block',
              path: [],
              command: 'update',
              args: { type: @block_type }
            }]
          }]
        }
      end
    end
  end
end

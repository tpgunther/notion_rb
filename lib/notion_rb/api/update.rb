# frozen_string_literal: true

module NotionRb
  module Api
    class Update < Base
      def initialize(params)
        @value = params[:value]

        super
      end

      def call
        response
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
              args: [[@value]]
            }]
          }]
        }
      end
    end
  end
end

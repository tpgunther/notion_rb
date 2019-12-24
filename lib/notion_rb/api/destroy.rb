# frozen_string_literal: true

module NotionRb
  module Api
    class Destroy < Base
      def initialize(params)
        @parent_id = params[:parent_id]

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
              path: [],
              command: 'update',
              args: { alive: false }
            }, {
              id: @parent_id,
              table: 'block',
              path: ["content"],
              command: 'listRemove',
              args: { id: @notion_id }
            }]
          }]
        }
      end
    end
  end
end

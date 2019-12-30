# frozen_string_literal: true

module NotionRb
  module Api
    class Destroy < Base
      def initialize(params)
        super

        @parent_id = params[:parent_id]
      end

      private

      def url
        'submitTransaction'
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
              path: ['content'],
              command: 'listRemove',
              args: { id: @notion_id }
            }]
          }]
        }
      end
    end
  end
end

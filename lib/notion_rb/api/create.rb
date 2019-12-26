# frozen_string_literal: true

module NotionRb
  module Api
    class Create < Base
      def initialize(params)
        super

        @parent_id = params[:parent_id]
        @notion_id = SecureRandom.uuid
        @created_at = (Time.now.to_i / 100) * 100_000
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
              command: 'set',
              args: { type: 'text', id: @notion_id, version: 1 }
            }, {
              id: @notion_id,
              table: 'block',
              path: [],
              command: 'update',
              args: { parent_id: @parent_id, parent_table: 'block', alive: true }
            }, {
              id: @parent_id,
              table: 'block',
              path: ['content'],
              command: 'listAfter',
              args: { id: @notion_id }
            }, {
              id: @notion_id,
              table: 'block',
              path: %w[
                properties
                title
              ],
              command: 'set',
              args: []
            }, {
              id: @notion_id,
              table: 'block',
              path: ['created_time'],
              command: 'set',
              args: @created_at
            }, {
              id: @notion_id,
              table: 'block',
              path: ['last_edited_time'],
              command: 'set',
              args: @created_at
            }]
          }]
        }
      end
    end
  end
end

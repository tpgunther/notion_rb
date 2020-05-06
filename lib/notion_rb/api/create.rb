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

      def block_uuid
        success? && @notion_id
      end

      private

      def url
        'submitTransaction'
      end

      def params
        NotionRb::RequestParams.new.add_transaction.tap do |transaction|
          transaction
            .add_operation(:set_block_type, @notion_id, 'block')
            .add_operation(:update_parent, @notion_id, @parent_id)
            .add_operation(:list_after, @parent_id, @notion_id)
            .add_operation(:set_block_title, @notion_id, [])
            .add_operation(:set_block_created_time, @notion_id, @created_at)
            .add_operation(:set_block_last_edited_time, @notion_id, @created_at)
        end.to_h
      end
    end
  end
end

require 'singleton'

module NotionRb
  module Utils
    class BlockCache
      include Singleton

      def initialize
        @blocks = []
      end

      def contains?(notion_id)
        @blocks.any? { |block| block[:notion_id] == notion_id }
      end

      def find(notion_id)
        add_blocks(notion_id) unless contains?(notion_id)

        @blocks.find { |block| block[:notion_id] == notion_id }
      end

      def children(notion_id)
        find(notion_id)[:children]
      end

      def clear
        @blocks = []
      end

      def add_collection_view_blocks(block)
        return unless block[:block_type] == 'collection_view_page'

        metadata = block.metadata
        blocks_ids = NotionRb::Api::QueryCollection.new(collection_id: metadata[:collection_id], view_id: metadata[:view_ids][0]).blocks
        block[:children] = blocks_ids
        blocks_ids.each do |block_id|
          add_blocks(block_id)
        end
      end

      private

      def add_blocks(uuid)
        blocks = NotionRb::Api::Get.new(notion_id: uuid).blocks

        new_block_ids = blocks.map { |block| block[:notion_id] }
        @blocks.each do |block|
          blocks << block unless new_block_ids.include?(block[:notion_id])
        end

        @blocks = blocks
      end
    end
  end
end

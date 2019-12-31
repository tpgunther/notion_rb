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
        add_block(notion_id) unless contains?(notion_id)

        @blocks.find { |block| block[:notion_id] == notion_id }
      rescue Mechanize::ResponseCodeError
        nil
      end

      def children(notion_id)
        return nil unless find(notion_id)

        find(notion_id)[:children]
      end

      def clear
        @blocks = []
      end

      private

      def add_block(uuid)
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

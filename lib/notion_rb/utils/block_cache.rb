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
        @blocks.find { |block| block[:notion_id] == notion_id }
      end

      def children(notion_id)
        find(notion_id)[:children]
      end

      def clear
        @blocks = []
      end

      def add_blocks(blocks)
        new_block_ids = blocks.map { |block| block[:notion_id] }
        @blocks.each do |block|
          blocks << block unless new_block_ids.include?(block[:notion_id])
        end
        @blocks = blocks
      end
    end
  end
end

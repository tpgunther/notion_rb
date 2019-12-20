require 'singleton'

module NotionRb
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

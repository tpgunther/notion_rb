# frozen_string_literal: true

module NotionRb
  class Block
    include NotionRb::Utils::UuidValidator
    include NotionRb::Utils::Types

    attr_accessor :uuid

    def initialize(url_or_uuid)
      @block_container = NotionRb::Utils::BlockCache.instance
      @uuid = parse_uuid url_or_uuid
      get_resource
    end

    def title
      @block[:title]
    end

    def title=(title)
      @block[:title] = title
      save
    end

    def type
      @block[:block_type]
    end

    def type=(type)
      return unless valid_block_type?(type)

      @block[:block_type] = type
      save
    end

    def metadata
      @block[:metadata]
    end

    def parent
      @parent ||= self.class.new(@block[:parent_id])
    end

    def children
      @children ||= @block_container.children(@uuid).map { |child_uuid| self.class.new(child_uuid) }
    end

    def save
      # TODO: add validations if needed
      post_resource
    end

    def destroy
      NotionRb::Api::Destroy.new(notion_id: @uuid, parent_id: @block[:parent_id]).success?
    end

    def restore
      NotionRb::Api::Restore.new(notion_id: @uuid, parent_id: @block[:parent_id]).success?
    end

    private

    def get_resource
      @block = @block_container.find(@uuid)
      @block_container.add_collection_view_blocks(@block)
    end

    def post_resource
      # TODO: detect changes if any before post
      NotionRb::Api::Update.new(notion_id: @uuid, title: @block[:title], block_type: @block[:block_type]).success?
    end
  end
end

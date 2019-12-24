module NotionRb
  class Block
    include NotionRb::UuidValidator

    attr_accessor :uuid

    def initialize(url_or_uuid)
      @block_container = BlockCache.instance
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

    private

    def get_resource
      unless @block_container.contains?(@uuid)
        @block_container.add_blocks(NotionRb::Api::Get.new(notion_id: @uuid).blocks)
      end

      @block = @block_container.find(@uuid)
    end

    def post_resource
      # TODO: detect changes if any before post
      NotionRb::Api::Update.new(notion_id: @uuid, title: @block[:title]).success?
    end
  end
end

module NotionRb
  class Block
    include NotionRb::UuidValidator

    attr_accessor :uuid

    def initialize(url_or_uuid)
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

    def save
      # TODO: add validations if needed
      post_resource
    end

    private

    def get_resource
      @blocks = NotionRb::Api::Get.new(notion_id: @uuid).blocks
      @block = @blocks.find { |b| b[:notion_id] == @uuid }
    end

    def post_resource
      # TODO: detect changes if any before post
      NotionRb::Api::Update.new(notion_id: @uuid, title: @block[:title]).success?
    end
  end
end

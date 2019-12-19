module NotionRb
  class Block
    attr_accessor :uuid

    def initialize(url_or_id)
      @uuid = parse_uuid url_or_id
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

    def parse_uuid(_url_or_id)
      'f0d7f6e4-c228-4cba-b860-a6f40ed3372e'
    end

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

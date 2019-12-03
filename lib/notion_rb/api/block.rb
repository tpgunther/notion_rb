module NotionRb
  module Api
    class Block < Base
      attr_reader :blocks

      def initialize(notion_id:)
        @blocks = []
        @notion_id = notion_id
        @converter = NotionRb::Utils::Converter.new

        super
      end

      private

      def url
        "#{API_BASE_URL}loadPageChunk"
      end

      def params
        {
          chunkNumber: 0,
          cursor: { stack: [] },
          stack: [],
          limit: 50,
          pageId: @notion_id,
          verticalColumns: false
        }
      end

      def receive_body(body)
        space = body['recordMap']['space'].keys.first
        @pages = body['recordMap']['space'][space]['value']['pages']
        @data = body['recordMap']['block']
      end

      def parse_body(notion_id = @notion_id, parent_slug = @parent_slug)
        return unless @data.key?(notion_id)

        value = @data[notion_id]['value']
        @blocks << @converter.convert(value, parent_slug)
        parse_children(value.dig('content') || [], notion_id)
      end

      def parse_children(children, parent_id)
        children.each do |child_id|
          parse_body(child_id, parent_id)
        end
      end
    end
  end
end

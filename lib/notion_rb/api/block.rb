# frozen_string_literal: true

module NotionRb
  module Api
    class Block < Base
      def initialize(notion_id:)
        @blocks = []
        @data = {}
        @notion_id = notion_id
        @converter = NotionRb::Utils::Converter.new

        super
      end

      def blocks
        return @blocks if @blocks.any?

        call
        @blocks
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

      def parse_response
        body = JSON.parse(response.body)
        @data = body.dig('recordMap', 'block')
      end

      def convert_values(notion_id = @notion_id)
        return unless @data.key?(notion_id)

        value = @data[notion_id]['value']
        @blocks << @converter.convert(value)
        parse_children(value.dig('content') || [])
      end

      def parse_children(children)
        children.each do |child_id|
          convert_values(child_id)
        end
      end
    end
  end
end

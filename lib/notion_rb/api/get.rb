# frozen_string_literal: true

module NotionRb
  module Api
    class Get < Base
      def initialize(_params)
        super

        @blocks = []
        @data = {}
      end

      def blocks
        return @blocks if @blocks.any?

        call
        @blocks
      end

      def call
        body = JSON.parse(response.body)
        @data = body.dig('recordMap', 'block')
        convert_values(@notion_id)
      end

      private

      def url
        "#{API_BASE_URL}loadPageChunk"
      end

      def params
        {
          chunkNumber: 0,
          cursor: { stack: [] },
          limit: 50,
          pageId: @notion_id,
          verticalColumns: false
        }
      end

      def convert_values(notion_id)
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

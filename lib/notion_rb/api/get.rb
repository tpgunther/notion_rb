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
        @collection_rows = body.dig('result', 'blockIds')
        data = body.dig('recordMap', 'block').merge(body.dig('recordMap', 'collection') || {})
        data.values.each do |value|
          convert_values(value.dig('value'))
        end
      end

      private

      def url
        'loadPageChunk'
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

      def convert_values(value)
        add_collection_data(value)
        @blocks << @converter.convert(value)
      end

      def add_collection_data(value)
        return unless value.key? 'schema'

        value['content'] = @collection_rows if @collection_rows
        value['type'] = 'collection'
      end
    end
  end
end

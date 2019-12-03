# frozen_string_literal: true

module NotionRb
  module Utils
    class Parsers
      def initialize(value, parent_slug, position)
        @value = value
        @parent_slug = parent_slug
        @position = position
      end

      def null
        {}
      end

      def base
        {
          notion_id: @value['id'],
          block_type: @value['type'],
          parent_slug: @parent_slug,
          position: @position
        }
      end

      def text
        base.merge(title: @value.dig('properties', 'title', 0, 0))
      end

      def todo
        text.merge(metadata: {
                     checked: @value.dig('properties', 'checked', 0, 0) == 'Yes'
                   })
      end

      def code
        text.merge(metadata: {
                     language: @value.dig('properties', 'language', 0, 0)&.downcase
                   })
      end

      def embed
        text.merge(metadata: {
                     source: @value.dig('properties', 'source', 0, 0)
                   })
      end

      def bookmark
        text.merge(metadata: {
                     source: @value.dig('properties', 'link', 0, 0)
                   })
      end
    end
  end
end

# frozen_string_literal: true

module NotionRb
  module Utils
    class Converter
      TYPE_MAPPER = {
        'collection_view' => :base,
        'collection_view_page' => :base,
        'column' => :base,
        'column_list' => :base,
        'divider' => :base,
        'copy_indicator' => :null,
        'table_of_contents' => :null,
        'factory' => :null,
        'page' => :text,
        'header' => :text,
        'bulleted_list' => :text,
        'numbered_list' => :text,
        'toggle' => :text,
        'sub_header' => :text,
        'sub_sub_header' => :text,
        'quote' => :text,
        'text' => :text,
        'to_do' => :todo,
        'code' => :code,
        'image' => :embed,
        'file' => :embed,
        'drive' => :embed,
        'bookmark' => :bookmark
      }.freeze

      def initialize
        @position = 0
      end

      def convert(value)
        data = parse(value)
        @position += 1
        data
      end

      private

      def parse(value)
        unless TYPE_MAPPER.key?(value['type'])
          raise ArgumentError, 'Invalid block type'
        end

        parser = Parser.new(value, @position)
        parser.send(TYPE_MAPPER[value['type']])
      end
    end
  end
end

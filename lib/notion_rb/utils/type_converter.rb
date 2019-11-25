module NotionRb
  module Utils
    class TypeConverter
      TYPE_MAPPER = {
        'collection_view' => :base_parser,
        'collection_view_page' => :base_parser,
        'column' => :base_parser,
        'column_list' => :base_parser,
        'divider' => :base_parser,
        'copy_indicator' => :null_parser,
        'table_of_contents' => :null_parser,
        'factory' => :null_parser,
        'page' => :text_parser,
        'header' => :text_parser,
        'bulleted_list' => :text_parser,
        'numbered_list' => :text_parser,
        'toggle' => :text_parser,
        'sub_header' => :text_parser,
        'sub_sub_header' => :text_parser,
        'quote' => :text_parser,
        'text' => :text_parser,
        'to_do' => :todo_parser,
        'code' => :code_parser,
        'image' => :embed_parser,
        'file' => :embed_parser,
        'drive' => :embed_parser,
        'bookmark' => :bookmark_parser
      }.freeze

      def initialize
        @position = 0
      end

      def convert(value, parent_slug)
        @value = value
        @parent_slug = parent_slug
        data = execute_by_type
        @position += 1
        data
      end

      private

      def execute_by_type
        parser = Parsers.new(@value, @parent_slug, @position)
        parser.send(TYPE_MAPPER[@value['type']])
      end
    end
  end
end

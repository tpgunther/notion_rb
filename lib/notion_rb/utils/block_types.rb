# frozen_string_literal: true

module NotionRb
  module Utils
    module BlockTypes
      TYPE_MAPPER = {
        'collection_view' => :base,
        'collection_view_page' => :base,
        'column' => :base,
        'column_list' => :base,
        'divider' => :base,
        'copy_indicator' => :null,
        'table_of_contents' => :null,
        'factory' => :null,
        'page' => :base,
        'header' => :base,
        'bulleted_list' => :base,
        'numbered_list' => :base,
        'toggle' => :base,
        'sub_header' => :base,
        'sub_sub_header' => :base,
        'quote' => :base,
        'text' => :base,
        'to_do' => :todo,
        'code' => :code,
        'image' => :image,
        'file' => :embed,
        'audio' => :embed,
        'drive' => :embed,
        'embed' => :embed,
        'bookmark' => :bookmark,
        'callout' => :callout
      }.freeze

      def valid_block_type?(value)
        TYPE_MAPPER.key?(value)
      end

      def select_parser(value)
        TYPE_MAPPER[value]
      end
    end
  end
end

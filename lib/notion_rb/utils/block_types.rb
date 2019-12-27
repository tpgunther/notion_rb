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

      def valid_block_type?(value)
        TYPE_MAPPER.key?(value)
      end
    end
  end
end

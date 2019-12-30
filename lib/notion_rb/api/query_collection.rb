# frozen_string_literal: true

module NotionRb
  module Api
    class QueryCollection < Base
      def initialize(params)
        super

        @collection_id = params[:collection_id]
        @collection_view_id = params[:collection_view_id]
      end

      def call
        JSON.parse(response.body).dig('result', 'blockIds')
      end

      private

      def url
        'queryCollection'
      end

      def params
        {
          collectionId: @collection_id,
          collectionViewId: @collection_view_id,
          query: { agregrate: [{}], filter: [], sort: [], filter_operation: 'and' },
          loader: { type: 'table', limit: 70, userTimeZone: 'America/Santiago', userLocale: 'en', loadContentCover: true }
        }
      end
    end
  end
end

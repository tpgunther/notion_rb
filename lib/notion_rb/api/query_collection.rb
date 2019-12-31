# frozen_string_literal: true

module NotionRb
  module Api
    class QueryCollection < Base
      def initialize(params)
        super

        @collection_id = params[:collection_id]
        @view_id = params[:view_id]
      end

      def blocks
        @blocks ||= call
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
          collectionViewId: @view_id,
          query: { agregrate: [{}], filter: [], sort: [], filter_operation: 'and' },
          loader: { type: 'table', limit: 70, userTimeZone: 'America/Santiago', userLocale: 'en', loadContentCover: true }
        }
      end
    end
  end
end

# frozen_string_literal: true

module NotionRb
  module Api
    class Base
      BASE_URL = 'https://www.notion.so/'
      API_BASE_URL = BASE_URL + 'api/v3/'
      SIGNED_URL_PREFIX = 'https://www.notion.so/signed/'
      S3_URL_PREFIX = 'https://s3-us-west-2.amazonaws.com/secure.notion-static.com/'
      S3_URL_PREFIX_ENCODED = 'https://s3.us-west-2.amazonaws.com/secure.notion-static.com/'
      REDEFINE_EXCEPTION = 'Define methods on subclass'

      def initialize(_params = {})
        @token_v2 = NotionRb.config[:token_v2]
      end

      def call
        response = agent.post(url, params.to_json, 'Content-Type' => 'application/json')
        receive_body(JSON.parse(response.body))
        parse_body
      end

      private

      def agent
        @agent = Mechanize.new
        cookie = Mechanize::Cookie.new(domain: 'www.notion.so',
                                       name: 'token_v2',
                                       value: @token_v2,
                                       path: '/',
                                       expires: (Date.today + 1).to_s)
        @agent.tap { |agent| agent.cookie_jar << cookie }
      end

      def url
        raise REDEFINE_EXCEPTION
      end

      # Configure params for the request
      def params
        raise REDEFINE_EXCEPTION
      end

      # Save variables from response body
      def receive_body(_response)
        raise REDEFINE_EXCEPTION
      end

      # Parse the body's variables
      def parse_body
        raise REDEFINE_EXCEPTION
      end
    end
  end
end

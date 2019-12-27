# frozen_string_literal: true

module NotionRb
  module Utils
    class Converter
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
        Parser.new(value, @position).parse
      end
    end
  end
end

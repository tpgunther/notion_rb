# frozen_string_literal: true

module NotionRb
  module Utils
    class Converter
      include NotionRb::Utils::BlockTypes

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
        unless valid_block_type?(value['type'])
          raise ArgumentError, 'Invalid block type'
        end

        parser = Parser.new(value, @position)
        parser.send(TYPE_MAPPER[value['type']])
      end
    end
  end
end

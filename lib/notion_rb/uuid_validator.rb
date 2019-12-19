# frozen_string_literal: true

module NotionRb
  module UuidValidator
    def parse_uuid(url_or_uuid)
      uuid = parse_from_url url_or_uuid
      hex = uuid.delete('-')

      parse_from_hex(hex)
    end

    def parse_from_url(url)
      if url.match? %r{https?://[\S]+}
        url.split('/')[-1].split('?')[0].split('-')[-1][0..31]
      else
        url
      end
    end

    def parse_from_hex(hex)
      raise ArgumentError, 'Incorrect hex size, must be equal to 32' unless hex.size == 32

      [20, 16, 12, 8].each do |position|
        hex = hex.to_s.insert(position, '-')
      end

      hex
    end
  end
end

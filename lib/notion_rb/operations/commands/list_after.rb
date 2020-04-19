# frozen_string_literal: true

module NotionRb
  module Operations
    module Commands
      class ListAfter < Base
        COMMAND = 'listAfter'
        NAME = :list_after

        def initialize(id, opts = {})
          opts.merge!(command: COMMAND)
          super
        end
      end
    end
  end
end

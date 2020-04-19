# frozen_string_literal: true

module NotionRb
  module Operations
    module Commands
      class Set < Base
        COMMAND = 'set'
        NAME = :set

        def initialize(id, opts = {})
          opts.merge!(command: COMMAND)
          super
        end
      end
    end
  end
end

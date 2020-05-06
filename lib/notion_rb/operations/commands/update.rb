# frozen_string_literal: true

module NotionRb
  module Operations
    module Commands
      class Update < Base
        COMMAND = 'update'
        NAME = :update

        def initialize(id, opts = {})
          opts.merge!(command: COMMAND)
          super
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative './base'
module NotionRb
  module Operations
    module Commands
      COMMANDS = Hash[
      ]

      class Factory
        def self.build(command_name, id, opts = {})
          COMMANDS.fetch(command_name).new(
            id,
            opts
          )
        end
      end
    end
  end
end

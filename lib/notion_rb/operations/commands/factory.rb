# frozen_string_literal: true

require_relative './base'
require_relative './set'

module NotionRb
  module Operations
    module Commands
      COMMANDS = Hash[
        [
          Set
        ].map { |klass| [klass::NAME, klass] }
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

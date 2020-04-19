# frozen_string_literal: true

require_relative './base'
require_relative './list_after'
require_relative './set'
require_relative './update'

module NotionRb
  module Operations
    module Commands
      COMMANDS = Hash[
        [
          ListAfter,
          Set,
          Update
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

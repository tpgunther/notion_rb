# frozen_string_literal: true

module NotionRb
  module Operations
    module Commands
      class Base
        attr_reader :id, :command, :table, :args, :path

        def initialize(id, opts = {})
          @id = id
          @command = opts.fetch(:command) do
            raise ArgumentError, 'Commands must specify command action key'
          end
          @table = opts[:table]
          @args = opts[:args]
          @path = opts.fetch(:path, [])
        end

        def to_h
          {
            id: id,
            table: table,
            path: path,
            command: command,
            args: args
          }
        end
      end
    end
  end
end

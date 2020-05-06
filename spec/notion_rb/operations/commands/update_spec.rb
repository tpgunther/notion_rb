# frozen_string_literal: true
require 'notion_rb/operations/commands/update'
SingleCov.covered!

module NotionRb::Operations::Commands
  RSpec.describe Update do
    let(:id) { '8d2d966c-12b1-45e7-a975-771f0bb13288' }
    let(:opts) { {} }
    subject(:instance) { described_class.new(id, opts) }

    it_behaves_like 'a command object'
  end
end

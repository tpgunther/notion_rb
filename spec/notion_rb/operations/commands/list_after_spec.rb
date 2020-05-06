# frozen_string_literal: true
require 'notion_rb/operations/commands/list_after'
SingleCov.covered!

module NotionRb::Operations::Commands
  RSpec.describe ListAfter do
    let(:id) { '8d2d966c-12b1-45e7-a975-771f0bb13288' }
    let(:opts) { {} }
    subject(:instance) { described_class.new(id, opts) }

    it_behaves_like 'a command object'
  end
end

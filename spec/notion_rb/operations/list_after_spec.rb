# frozen_string_literal: true

require 'notion_rb/operations/list_after'
SingleCov.covered!

module NotionRb::Operations
  RSpec.describe ListAfter do
    let(:id) { 'cb71f959-2f27-4756-a5d2-59b355cebef5' }
    let(:list_after_id) { '09ff327d-885e-4320-bc86-a2e19700ed23' }
    let(:opts) { {} }

    subject(:instance) { described_class.new(id, list_after_id, opts) }

    it_behaves_like 'an operation object'
  end
end

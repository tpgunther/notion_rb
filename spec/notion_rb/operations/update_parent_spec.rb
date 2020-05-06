# frozen_string_literal: true

require 'notion_rb/operations/update_parent'
SingleCov.covered!

module NotionRb::Operations
  RSpec.describe UpdateParent do
    let(:id) { 'cb71f959-2f27-4756-a5d2-59b355cebef5' }
    let(:parent_id) { '182125b2-b602-48fc-840d-ef191fd5d93d' }
    let(:opts) { {} }

    subject(:instance) { described_class.new(id, parent_id, opts) }

    it_behaves_like 'an operation object'
  end
end

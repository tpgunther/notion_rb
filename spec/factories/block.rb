# frozen_string_literal: true

FactoryBot.define do
  factory :block, class: OpenStruct do
    notion_id { SecureRandom.uuid }
    title { 'Test title' }
    parent_id { SecureRandom.uuid }

    trait :page do
      type { 'page' }
    end

    trait :text do
      type { 'text' }
    end
  end
end

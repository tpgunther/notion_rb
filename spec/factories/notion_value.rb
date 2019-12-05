# frozen_string_literal: true

FactoryBot.define do
  factory :notion_value, class: OpenStruct do
    id { SecureRandom.uuid }
    version { 51 }
    properties { { title: [['Test title']] } }
    created_by { SecureRandom.uuid }
    created_time { Time.now.to_i }
    last_edited_by { SecureRandom.uuid }
    last_edited_time { Time.now.to_i }
    parent_id { SecureRandom.uuid }
    parent_table { 'block' }
    alive { true }
    created_by_table { 'notion_user' }
    created_by_id { SecureRandom.uuid }
    last_edited_by_table { 'notion_user' }
    last_edited_by_id { SecureRandom.uuid }

    trait :text do
      type { 'text' }
    end

    trait :page do
      type { 'page' }
      content do
        3.times.map { json(:notion_value, :text, parent_id: id)[:id] }
      end
    end
  end
end

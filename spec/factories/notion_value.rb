# frozen_string_literal: true

FactoryBot.define do
  factory :notion_value, class: OpenStruct do
    id { SecureRandom.uuid }
    version { rand(100) }
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

    trait :table_of_contents do
      type { 'table_of_contents' }
      properties { {} }
    end

    trait :page do
      type { 'page' }
      content do
        3.times.map { json(:notion_value, :text, parent_id: id)[:id] }
      end
    end

    trait :text do
      type { 'text' }
    end

    trait :todo do
      type { 'to_do' }
      properties { { title: [['Todo title']], checked: [['Yes']] } }

      trait :off do
        properties { { title: [['Todo title']], checked: [['No']] } }
      end
    end

    trait :code do
      type { 'code' }
      properties { { title: [['Code']], language: [['ruby']] } }
    end

    trait :embed do
      type { 'image' }
      properties { { title: [['Embed title']], source: [['https://www.github.com']] } }
    end

    trait :bookmark do
      type { 'bookmark' }
      properties { { title: [['Bookmark title']], link: [['https://www.github.com']] } }
    end

    trait :callout do
      type { 'callout' }
      format { { page_icon: 'Icon' } }
    end

    trait :invalid do
      type { :invalid }
    end
  end
end

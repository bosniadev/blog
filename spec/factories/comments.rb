# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user_id { create(:user).id }
    post_id { create(:post).id }
  end
end

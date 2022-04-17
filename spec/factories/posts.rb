# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user_id { create(:user).id }
  end
end

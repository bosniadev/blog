# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    user_id { create(:user).id }
    comment_id { create(:comment).id }
    kind { :like }
  end
end

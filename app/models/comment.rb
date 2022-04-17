# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :reactions, dependent: :delete_all

  validates :user_id, presence: true
  validates :post_id, presence: true
end

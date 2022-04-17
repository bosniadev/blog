# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all

  scope :filter_by_user_id, ->(user_id) { where(user_id:) }

  validates :user_id, presence: true
end

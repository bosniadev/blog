# frozen_string_literal: true

class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  enum kind: %i[thumbsup like smile]

  validates :user_id, presence: true
  validates :comment_id, presence: true
  validates :kind, presence: true
  validates :user_id, uniqueness: { scope: %i[kind comment_id] }
end

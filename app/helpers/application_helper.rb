# frozen_string_literal: true

module ApplicationHelper
  def can_edit?(model)
    model.user_id == current_user&.id
  end

  def can_delete?(model)
    model.user_id == current_user&.id
  end
end

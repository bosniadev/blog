# frozen_string_literal: true

module Posts
  module CommentsHelper
    def can_react?(comments, comment, kind)
      @reactions ||= current_user.reactions.where(comment_id: comments.map(&:id)).pluck(:comment_id, :kind)

      @reactions.exclude?([comment.id, kind.to_s])
    end
  end
end

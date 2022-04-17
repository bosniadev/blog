# frozen_string_literal: true

module Posts
  module Comments
    class ReactionsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_post
      before_action :set_comment

      def create
        @reaction = @comment.reactions.new(reaction_params.merge(user_id: current_user.id))
        return unless @reaction.save

        PostsChannel.broadcast_to(@post,
                                  { added_reaction: [@comment.id, @reaction.kind,
                                                     @comment.reactions.where(kind: @reaction.kind).count] })
        redirect_to post_comments_url(@post), notice: 'Reaction was successfully created.'
      end

      def destroy
        @comment.reactions.where(user_id: current_user.id).find_by_kind(params[:id]).delete
        PostsChannel.broadcast_to(@post,
                                  { removed_reaction: [@comment.id, params[:id],
                                                       @comment.reactions.where(kind: params[:id]).count] })
        redirect_to post_comments_url(@post), notice: 'Reaction was successfully destroyed.'
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end

      def set_comment
        @comment = @post.comments.find(params[:comment_id])
      end

      def reaction_params
        params.permit(:kind)
      end
    end
  end
end

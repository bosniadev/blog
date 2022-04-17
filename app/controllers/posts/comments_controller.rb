# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    before_action :authenticate_user!, except: %i[index]
    before_action :set_post
    before_action :set_comment, except: %i[index new create]
    before_action :set_comments, only: %i[index new edit]

    def new
      @comment = @post.comments.new
    end

    def index; end

    def edit; end

    def create
      @comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
      if @comment.save
        PostsChannel.broadcast_to(
          @post, {
            comment_create: render_to_string(
              'posts/comments/_comment',
              layout: false,
              locals: { post: @post, comment: @comment, channel: true }
            )
          }
        )
        redirect_to post_comments_url(@post), notice: 'Comment was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @comment.update(comment_params)
        PostsChannel.broadcast_to(@post, { comment_update: [@comment.id, @comment.description] })
        redirect_to post_comments_url(@post), notice: 'Comment was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @comment.destroy
      PostsChannel.broadcast_to(@post, { comment_destroy: @comment.id })
      redirect_to post_comments_url(@post), notice: 'Comment was successfully destroyed.'
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = @post.comments.find(params[:id])
    end

    def set_comments
      @comments = @post.comments.left_joins(:reactions)
                       .select('comments.*, SUM(reactions.kind=0) as thumbsup_count, SUM(reactions.kind=1) as like_count, SUM(reactions.kind=2) as smile_count')
                       .group('comments.id')
    end

    def comment_params
      params.require(:comment).permit(:description)
    end
  end
end

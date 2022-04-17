# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[update destroy edit]
  before_action :set_posts, only: %i[index new edit]

  def index; end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def edit; end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_url, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      PostsChannel.broadcast_to(@post, { post_update: [@post.title, @post.description] })
      redirect_to posts_url, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    PostsChannel.broadcast_to(@post, { post_destroy: @post.id })
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def set_posts
    @users = User.all
    @posts = Post.all
    @posts = @posts.filter_by_user_id(params[:user_id]) if params[:user_id].present?
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end

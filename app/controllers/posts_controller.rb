class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @uniq = uniq_user(@post) unless @post.comments.empty?
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    redirect_to post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids: [], categories_attributes: [:name])
  end

  def uniq_user(post)
    array = []
    post.comments.each do |comment|
      array << comment.user
    end
    array.uniq
  end
end

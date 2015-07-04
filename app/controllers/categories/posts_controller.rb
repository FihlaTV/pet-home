class Categories::PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @category = Category.find(params[:category_id])
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
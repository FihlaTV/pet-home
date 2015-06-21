class Categories::PostsController < ApplicationController
  
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
end
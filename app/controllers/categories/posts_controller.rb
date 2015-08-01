class Categories::PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @category = Category.friendly.find(params[:category_id])
    @post = Post.find(params[:id])
  end

  def new
    @category = Category.friendly.find(params[:category_id])
    @post = @category.posts.new
  end

  def create
    @category = Category.friendly.find(params[:category_id])
    @post = current_user.posts.build(post_params)
    @post.category = @category

    if @post.save
      flash[:success] = "You have succesfully created a new post."
      redirect_to [@category, @post]
    else
      flash[:error] = "Error occured. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
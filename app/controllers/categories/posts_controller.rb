class Categories::PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @category = Category.friendly.find(params[:category_id])
    @post = Post.find(params[:id])
  end

  def new
    @category = Category.friendly.find(params[:category_id])
    @post = Post.new
    @post.build_location 
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
    @category = Category.friendly.find(params[:category_id])
    @post = Post.find(params[:id])
    @post.build_location if @post.location.blank?
  end

  def update
    @category = Category.friendly.find(params[:category_id])
    @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
        flash[:success] = "Post was upated."
        redirect_to [@category, @post]
      else
        flash[:error] = "There was an error saving a post, please try again."
        render :new
      end
  end

  def destroy
    @category = Category.friendly.find(params[:category_id])
    @post = Post.find(params[:id])
    title = @post.title

      if @post.destroy
       flash[:success] = "\"#{title}\" was deleted successfully."
       redirect_to @category
     else
       flash[:error] = "There was an error deleting the topic."
       render :show
     end
  end

  private 

    def post_params
      params.require(:post).permit(:title, :body, location_attributes: [:id, :street, :city, :zipcode, :_destroy])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

end
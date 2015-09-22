class Categories::PostsController < ApplicationController
  before_action :set_category
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @post = Post.find(params[:id])
  end

  def new    
    @post = Post.new
    @location = Location.new
    if current_user.locations.first
      @post.locations = current_user.locations.first
    else
      @post.locations.build
    end

  end

  def create   

    @post = current_user.posts.build(post_params)
    @post.category = @category

    if @post.save
      flash[:success] = "You have succesfully created a new post."
      redirect_to [@category, @post]
    else
      flash[:danger] = "Error occured. Please try again."
      render :new
    end
  end

  def edit  
    @post = Post.find(params[:id])
    if @post.locations.blank?
    
      if current_user.locations.first
        @post.location = current_user.locations.first 
      else
         @post.locations.build
      end
    end
  end

  def update    
    @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
        flash[:success] = "Post was upated."
        redirect_to [@category, @post]
      else
        flash[:danger] = "There was an error saving a post, please try again."
        render :new
      end
  end

  def destroy
    @post = Post.find(params[:id])
    title = @post.title

      if @post.destroy
        flash[:success] = "\"#{title}\" was deleted successfully."
        redirect_to @category
      else
        flash[:danger] = "There was an error deleting the topic."
        render :show
      end
  end

  private 

    def set_category
      @category = Category.friendly.find(params[:category_id])
    end

    def post_params
      params.require(:post).permit(:title, :body, location: [:id, :street, :city, :zipcode, :_destroy])
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

end
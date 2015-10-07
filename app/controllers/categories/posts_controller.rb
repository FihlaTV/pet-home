class Categories::PostsController < ApplicationController
  before_action :set_category
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @postattachments = @post.postattachments
  end

  def new    
    @post = Post.new
    # if current_user.locations.first
    #   @post.locations = current_user.locations.first
    # else
      @post.build_location
    # end

  end

  def create   

    @post = current_user.posts.build(post_params)
    @post.category = @category

    if @post.save
      if params[:pictures]
        params[:pictures].each do |picture|
          @post.postattachments.create(picture: picture)
        end
      end
      
      @postattachments = @post.postattachments
      flash[:success] = "You have succesfully created a new post."
      redirect_to edit_category_post_path(@category, @post)
    else
      flash[:danger] = "Error occured. Please try again."
      render :new
    end
  end

  def edit 
    @postattachments = @post.postattachments
    
    if @post.location.blank?
    
      # if current_user.locations.first
      #   @post.location = current_user.locations.first 
      # else
        @post.build_location
    end
  end

  def update    
      if @post.update_attributes(post_params)
        if params[:pictures]
        params[:pictures].each do |picture|
          @post.postattachments.create(picture: picture)
        end
      end
        flash[:success] = "Post was upated."
      redirect_to edit_category_post_path(@category, @post)
      else
        flash[:danger] = "There was an error saving a post, please try again."
        render :new
      end
  end

  def destroy
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

    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, location_attributes: [:id, :street, :city, :zipcode, :state, :_destroy])
    end

    def correct_user
      @post = current_user.posts.find_by(slug: params[:id])
      redirect_to root_url if @post.nil?
    end

end
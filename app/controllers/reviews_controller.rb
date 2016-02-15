class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :authorize_user, only: [:destroy]

  def create
    @post = Post.friendly.find(params[:post_id])
    @review = @post.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      flash[:success] = "Your review was added."
      redirect_to [@post.category, @post]
    else
      flash[:danger] = "Review failed to save."
      redirect_to [@post.category, @post]
    end
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @review = @post.reviews.find(params[:id])

    if @review.destroy
      flash[:success] = "Review was removed."
      redirect_to [@post.category, @post]
    else
      flash[:danger] = "Review can't be deleted this time, please try again."
      redirect_to [@post.category, @post]
    end
  end

  private 

    def review_params
      params.require(:review).permit(:body)
    end

    def authorize_user
      @review = Review.find(params[:id])
      unless (current_user.admin? || @review.user == current_user)
        flash[:danger] = "You don't have permission to delete a review." 
        redirect_to [@review.post.category, @review.post]
      end
    end
end

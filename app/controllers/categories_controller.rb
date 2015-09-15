class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_category

  def show
    @category = Category.friendly.find(params[:id])
    @posts = @category.posts
  end

  private 

  def invalid_category
    logger.error "Attempt to access invalid category #{params[:id]}"
    flash[:danger] = "Invalid category"
    redirect_to root_url
  end
end

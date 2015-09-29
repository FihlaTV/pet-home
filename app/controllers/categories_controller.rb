class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_category
  before_action :set_category, except: [:index, :new, :create]
  before_action :logged_in_user, except: [:show]
  before_action :admin_user,     except: [:show]
  
  def index
    @categories = Category.all
  end

  def show
    @posts = @category.posts.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "Category has been created!"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    name = @category.name

    if @category.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to root_url
    else
      flash[:error] = "There was an error deleting the category."
      render :show
    end
  end

  private 

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end


  def admin_user
    redirect_to(root_url) unless current_user.admin?
    end

  def invalid_category
    logger.error "Attempt to access invalid category #{params[:id]}"
    flash[:danger] = "Invalid category"
    redirect_to root_url
  end
end

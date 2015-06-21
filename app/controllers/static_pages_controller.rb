class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @categories = Category.all
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end

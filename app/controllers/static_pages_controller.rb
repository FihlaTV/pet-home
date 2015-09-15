class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @posts = Post.where("posts.created_at > ?", 10.days.ago)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end

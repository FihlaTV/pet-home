class PostsController < ApplicationController
  def index
    if logged_in?
      @posts = Post.where("posts.created_at > ?", 10.days.ago).paginate(page: params[:page])
    else
      @posts = Post.all.paginate(page: params[:page])
    end
  end
end

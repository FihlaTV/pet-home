class PostsController < ApplicationController
  def index
    @posts = Post.where("posts.created_at > ?", 10.days.ago)
  end
end

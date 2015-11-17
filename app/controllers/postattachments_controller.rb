class PostattachmentsController < ApplicationController
  def destroy
    @postattachment = Postattachment.find(params[:id])
    post = @postattachment.post

    @postattachment.destroy
    @postattachments = Postattachment.where(post_id: post.id)

    respond_to :js
  end
end
class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :set_conversation
  before_action :correct_user, only: :destroy

  def index
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order("created_at DESC")
    else
      redirect_to conversations_path, alert: "You don't have permission to view this."
    end
  end

  def create
    @message = @conversation.messages.new(message_params)
    @messages = @conversation.messages.order("created_at DESC")

    if @message.save
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @message.destroy
    flash[:success] = "Message deleted"
    redirect_to conversation_messages_path
  end

  private

    def set_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def message_params
      params.require(:message).permit(:content, :user_id)
    end

    def correct_user
      @message = @conversation.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end
end
module Messages
  class ConversationsController < ApplicationController
    def index
      @conversations = current_user.conversations.sort { |a, b| b.last_message_dtg <=> a.last_message_dtg }
    end

    def show
      @conversation = Conversation.find(params[:id])
      redirect_to messages_root_path unless @conversation.users.include?(current_user)
      @conversations = current_user.conversations.sort { |a, b| b.last_message_dtg <=> a.last_message_dtg }
      @message = Message.new
    end
  end
end

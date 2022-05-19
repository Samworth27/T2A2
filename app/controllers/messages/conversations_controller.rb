module Messages
  class ConversationsController < ApplicationController
    def index
      @path = request.path
      @conversations = current_user.conversations.sort { |a, b| b.last_message_dtg <=> a.last_message_dtg }
    end

    def show
      @path = request.path
      @conversations = current_user.conversations.sort { |a, b| b.last_message_dtg <=> a.last_message_dtg }
      @conversation = Conversation.find(params[:id])
      @message = Message.new
    end
  end
end

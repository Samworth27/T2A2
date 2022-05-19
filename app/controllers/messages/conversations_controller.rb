module Messages
  class ConversationsController < ApplicationController
    def index
      @path = request.path
      @conversations = current_user.conversations
    end

    def show
      @path = request.path
      @conversations = current_user.conversations
      @conversation = @conversations.first
      @message = Message.new
    end
  end
end

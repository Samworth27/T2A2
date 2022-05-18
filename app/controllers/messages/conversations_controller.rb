module Messages
  class ConversationsController < ApplicationController
    def index
      puts current_user
      @conversations = current_user.conversations
      @conversation = @conversations.first
    end

    def show
      @path = request.path
      @conversations = current_user.conversations
      @conversation = @conversations.first
    end
  end
end

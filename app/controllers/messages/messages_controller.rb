module Messages
  class MessagesController < ApplicationController
    def create
      @recipient = User.find(params[:message][:recipient])
      @conversation = Conversation.between(current_user, @recipient)
      @user = current_user
      @message = Message.new
      if @message.update(body: params[:message][:body], sender: current_user, conversation: @conversation)
        @conversation.save
        redirect_to messages_conversation_path(@conversation)
      else
        @conversations = current_user.conversations
        render 'messages/conversations/show', status: :unprocessable_entity
      end
    end
  end
end

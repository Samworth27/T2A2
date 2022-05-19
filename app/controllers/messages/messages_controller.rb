module Messages
  class MessagesController < ApplicationController
    def create
      @recipient = User.find(params[:message][:recipient])
      @conversation = Conversation.between(current_user, @recipient)
      @listing = Listing.find(params[:message][:listing])
      @message = Message.new
      if @message.update(body: params[:message][:body], sender: current_user, conversation: @conversation, listing: @listing)
        @conversation.save
        redirect_to messages_conversation_path(@conversation)
      else
        @item = @listing.item
        @category = @item.category
        render 'listings/show', layout: 'application', status: :unprocessable_entity
      end
    end

    def reply
      @recipient = User.find(params[:message][:recipient])
      @conversation = Conversation.between(current_user, @recipient)
      @message = Message.new
      if @message.update(body: params[:message][:body], sender: current_user, conversation: @conversation)
        redirect_to messages_conversation_path(@conversation)
      else
        @conversations = current_user.conversations
        render 'messages/conversations/show', status: :unprocessable_entity
      end
    end
  end
end

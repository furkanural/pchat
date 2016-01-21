class UsersController < ApplicationController
  def show
    @conversation = Conversation.find_by token: params[:token]
    @user = User.find params[:id]
  end
  def update
    @conversation = Conversation.find_by token: params[:conversation]
    if @conversation.pin.eql? params[:pin]
      @user = User.find params[:id]
      session[:key] = @user.id
      redirect_to conversation_path(@conversation, :token => @conversation.token, :user => @user.token)
    else
      redirect_to user_path( @user, token: @conversation.token)
    end
  end
end

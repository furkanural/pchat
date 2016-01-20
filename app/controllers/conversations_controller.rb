class ConversationsController < ApplicationController
  def create
    if session[:key].nil?
      @user = User.create!
      session[:key] = @user.id
    else
      @user = User.find session[:key]
    end
    @conversation = Conversation.create!(starter:@user)
    cookies[:channel] = @conversation.token
    respond_with @conversation, location: conversation_path(@conversation, :token => @conversation.token)
  end
  def new
    @locale = cookies['locale'].nil?
    @conversation = Conversation.new
    respond_with @conversation
  end
  def show
    @conversation = Conversation.includes(:messages).find_by(id:params[:id], token:params[:token])
    @popup = true
    redirect_to root_path if @conversation.nil? and return
    if @conversation.receiver.nil? and @conversation.starter_id != session[:key]
      if session[:key].nil?
        @user = User.create!
        session[:key] = @user.id
      else
        @user = User.find session[:key]
      end
      @conversation.update_attributes(receiver: @user)
      cookies[:channel] = @conversation.token
      @popup = false
    elsif @conversation.receiver.present?
      redirect_to root_path and return
    end
    respond_with @conversation
  end
end

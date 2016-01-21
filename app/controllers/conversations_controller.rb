class ConversationsController < ApplicationController
  def create
    if session[:key].nil?
      @user = User.create!
      session[:key] = @user.id
    else
      @user = User.find session[:key]
    end
    @conversation = Conversation.new(starter:@user, pin:params[:conversation][:pin])
    if @conversation.save
      cookies[:channel] = @conversation.token
      respond_with @conversation, location: conversation_path(@conversation, :token => @conversation.token, :user => @user.token)
    else
      respond_with @conversation
    end
  end
  def new
    @locale = cookies['locale'].nil?
    @conversation = Conversation.new
    respond_with @conversation
  end
  def show
    @conversation = Conversation.includes(:messages).find_by(id:params[:id], token:params[:token])
    @popup = true
    @user = nil
    if @conversation.nil?
      redirect_to root_path and return
    end
    if @conversation.receiver.present?
      redirect_to root_path and return
    end

    if params[:user].nil? and session[:key].nil?
      @user = User.create!
      session[:key]=@user.id
      redirect_to user_path(@user, token: @conversation.token) and return
    elsif session[:key].present? and params[:user].nil?
      @user = User.find session[:key]
      redirect_to user_path(@user, token: @conversation.token) and return
    elsif session[:key].present?
      @user = User.find session[:key]
    elsif params[:user].nil?
      redirect_to root_path and return
    end

    if @conversation.receiver.nil? and @user.id != @conversation.starter_id
      @conversation.update_attributes(receiver: @user)
      cookies[:channel] = @conversation.token
      @popup = false
    end
    respond_with @conversation
  end
end

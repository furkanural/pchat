require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  helper_method :current_user, :channel
  before_action :set_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
  def set_locale
    cookies[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = params[:locale] || cookies[:locale] ||I18n.default_locale
  end
  def current_user
    @current_user ||= User.find_by_id(session[:key])
  end
  def channel
    @channel ||= cookies[:channel]
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  class NotFound < StandardError
  end

  rescue_from NotFound, :with => :custom_error
 
  def get_entity entity
  	raise NotFound unless entity.present?
    return entity
  end

  def custom_error
  	render "public/404", :status => 404
  end

end

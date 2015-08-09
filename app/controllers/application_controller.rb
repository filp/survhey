class ApplicationController < ActionController::Base
  include UniqueUserIdentification

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :redirect_to_apex if Rails.env.production?

private

  def redirect_to_apex
    if request.host =~ /\Awww\./
      redirect_to request.host[4..-1] + request.fullpath, status: :moved_permanently
    end
  end
end

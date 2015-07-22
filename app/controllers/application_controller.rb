class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    nil
  end

  def command_metadata
    {
      controller_path: controller_path,
      action_name: action_name,
      remote_ip: request.remote_ip,
      referer: request.referer
    }
  end
end

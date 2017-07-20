class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def isadmin
			redirect_to root_path if user_signed_in? && (current_user.email != 'admin@sk.com')
	end
end

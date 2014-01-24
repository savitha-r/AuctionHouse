class HomeController < ApplicationController

	def index
		if signed_in?
			redirect_to admin_dashboard_path if current_user.is_admin?
		end
	end
	
end

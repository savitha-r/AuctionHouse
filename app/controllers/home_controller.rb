class HomeController < ApplicationController

	def index
		if signed_in?
			if current_user.is_admin?
				redirect_to admin_dashboard_path
			else
				redirect_to members_dashboard_path
			end
		end
	end
	
end

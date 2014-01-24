class Admin::AdminController < ApplicationController
	before_filter :check_is_admin

	def index
	end

	def check_is_admin
		unless current_user.is_admin?
			flash[:notice] = "You do not have access to the page requested."
			redirect_to root_path
		end
	end
end

class Members::MembersController < ApplicationController
	before_filter :check_current_user

	def check_current_user
		if !signed_in?
			redirect_to root_path
		end
	end

end

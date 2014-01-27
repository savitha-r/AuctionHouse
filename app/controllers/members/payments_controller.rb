# please explain this class

class Members::PaymentsController < Members::MembersController  
	def new
		@payment = Payment.new
	end

	def create
		@payment = current_user.payments.build(payments_parameters)
		if @payment.save
			render "pay"
		else
			render "new"
		end
	end

	def pay
		@payment = get_entity Payment.find_by_id(params[:payment_id])
		@host = default_url_options[:host]
	end

	def success
		@payment = get_entity Payment.find_by_id(params[:payment_id])
		@payment.grant_credit
		current_user.update_credit(@payment.credit_points)
		flash[:notice] = "Your credits have been updated successfully."
		redirect_to members_payments_path
	end

	def fail
		@payment = get_entity Payment.find_by_id(params[:payment_id])
		@payment.fail
		flash[:notice] = "Payment process was unsuccessful please try again."
		redirect_to members_payments_path
	end



	private
	def payments_parameters
		params.require(:payment).permit(:amount)
	end
end

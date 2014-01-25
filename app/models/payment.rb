class Payment < ActiveRecord::Base

	belongs_to :user
	
	STATUS = { :PENDING => "PENDING", :SUCCESS => "SUCCESS", :FAIL => "FAIL"}

	AMOUNTS = { :FIVE => 5, :TEN => 10, :FIFTY => 50}

	before_create :set_default_status

	def set_default_status
		self.status = STATUS[:PENDING]
	end

	def grant_credit
		self.credit_points = self.amount * 100
		self.status = STATUS[:SUCCESS]
		self.save
	end

	def fail
		self.status = SUCCESS[:FAIL]
		self.credit_points =0
		self.save
	end
end

class Bid < ActiveRecord::Base

	belongs_to :item
	belongs_to :user

	# which one is better and why for
	# STATUS = [PENDING = "STATUS_PENDING", SUCCESS = "STATUS_SUCCESS", FAIL = "STATUS_FAIL", INSUFFICIENT_FUNDS = "STATUS_INSUFFICIENT FUNDS"]
	STATUS = { :PENDING => "PENDING", :SUCCESS => "SUCCESS", :FAIL => "FAIL", :INSUFFICIENT_FUNDS => "INSUFFICIENT FUNDS"}

	# what could go wrong with your argument?
	def self.initialize_with_defaults(item,user,amount)
		@bid = Bid.new
		@bid.item = item
		@bid.user = user
		@bid.bid_amount = amount
		@bid.bid_status = STATUS[:PENDING]
		return @bid
	end

	def set_status(status)
		# what could go wrong here?
		self.bid_status = status
		self.save
	end

end

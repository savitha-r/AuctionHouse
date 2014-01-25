class Bid < ActiveRecord::Base

	belongs_to :item
	belongs_to :user

	STATUS = { :PENDING => "PENDING", :SUCCESS => "SUCCESS", :FAIL => "FAIL", :INSUFFICIENT_FUNDS => "INSUFFICIENT FUNDS"}

	def self.initialize_with_defaults(item,user,amount)
		@bid = Bid.new
		@bid.item = item
		@bid.user = user
		@bid.bid_amount = amount
		@bid.bid_status = STATUS[:PENDING]
		return @bid
	end

	def set_status(status)
		self.bid_status = status
		self.save
	end

end

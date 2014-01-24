class Item < ActiveRecord::Base

  has_many :bids, dependent: :destroy
  has_many :users, :through => :bids

  def next_bid
  	self.starting_bid + self.bid_unit
  end

end

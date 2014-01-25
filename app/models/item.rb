class Item < ActiveRecord::Base

  has_many :bids, dependent: :destroy
  has_many :users, :through => :bids

  before_create :check_starting_ending_time, :set_price

  def next_bid
  	self.price + self.bid_unit
  end

  def place_bid
  	self.price = self.price + self.bid_unit
  	self.save
  end

  def set_price
  	self.price = self.starting_bid
  end

  def check_starting_ending_time
  	if self.starting_time < DateTime.now
  	  self.errors.add(:starting_time, "The starting time cannot be before current time.")
  	end
  	if self.ending_time < DateTime.now
  	  self.errors.add(:ending_time, "The ending time cannot be before current time.")
  	end
  	if self.starting_time > self.ending_time
  	  self.errors.add(:starting_time, "The starting time should be before ending time.")
  	end
  end

end

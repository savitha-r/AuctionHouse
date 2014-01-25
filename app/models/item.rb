class Item < ActiveRecord::Base

  has_many :bids, dependent: :destroy
  has_many :users, :through => :bids

  before_create :check_starting_ending_time, :set_price

  def next_bid
  	self.price + self.bid_unit
  end

  def update_ending_time
    self.ending_time = self.ending_time + 20.seconds
    self.save
    job = Delayed::Job.find_by_item_id(self.id)
    job.delete
  end


  def place_bid
  	self.price = self.price + self.bid_unit
  	self.save
    self.update_ending_time
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

  def check_expire
    self.ending_time < DateTime.now
  end


  def item_expired
    max_bid = self.bids.maximum(:bid_amount)
    winner = max_bid.user
    if winner.deduct(max_bid.bid_amount)
      max_bid.set_status(BID::STATUS[:SUCCESS])
    else
      max_bid.set_status(BID::STATUS[:INSUFFICIENT_FUNDS])
    end
    self.close_bids
  end

  def close_bids
    bids = self.bids.where(:bid_status => BID::STATUS[:PENDING])
    bids.each do |bid|
      bid.set_status(BID::STATUS[:FAIL])
    end
  end

end

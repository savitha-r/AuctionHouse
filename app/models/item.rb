class Item < ActiveRecord::Base

  has_many :bids, dependent: :destroy
  has_many :users, :through => :bids

  before_create :check_starting_ending_time, :set_price

  def next_bid
  	self.price + self.bid_unit
  end

  def update_ending_time
    self.ending_time = self.ending_time + 20.seconds
    self.save # what could go wrong here?

    # delete this job, then how to check when the job finished?
    job = Delayed::Job.find_by_item_id(self.id)
    job.delete
  end


  def place_bid
    # what next_bid then?
  	self.price = self.price + self.bid_unit
  	self.save
    self.update_ending_time #save twice in update_ending_time

  end

  # does method name reflect the implement content?
  def set_price
  	self.price = self.starting_bid
  end

  def check_starting_ending_time
  	if self.starting_time < DateTime.now
  	  self.errors.add(:starting_time, "The starting time cannot be before current time.")
  	end

    # is this necessary?
  	if self.ending_time < DateTime.now
  	  self.errors.add(:ending_time, "The ending time cannot be before current time.")
  	end
  	if self.starting_time > self.ending_time
  	  self.errors.add(:starting_time, "The starting time should be before ending time.")
  	end
  end

  # bad method name
  def check_expire
    self.ending_time < DateTime.now
  end

  def self.to_csv(items)
    CSV.generate do |csv|
      csv << column_names
      # what's wrong with using ".each"?
      items.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
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
    # what's wrong with this?
    bids.each do |bid|
      bid.set_status(BID::STATUS[:FAIL])
    end
  end

end

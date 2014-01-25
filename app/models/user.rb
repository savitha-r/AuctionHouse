class User < ActiveRecord::Base

  has_many :bids, dependent: :destroy
  has_many :items, :through => :bids
  has_many :payments



  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def is_admin?
    self.is_admin == true
  end

  def update_credit(credit_points)
    self.creditpoints = self.creditpoints + credit_points
    self.save
  end

  def deduct(bid_amount)
    if self.creditpoints >= bid_amount
      self.creditpoints = self.creditpoints - bid_amount
      self.save
      return true
    else
      return false
    end
  end
  
end

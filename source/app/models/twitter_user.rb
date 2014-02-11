class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates :username, :twitter_id, uniqueness: true
end

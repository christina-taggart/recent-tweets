class Tweet < ActiveRecord::Base
  belongs_to :twitter_user
  validates :tweet_id, uniqueness: true
end

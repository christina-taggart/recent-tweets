class User < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    self.tweets.first.created_at < Time.now - 900
  end


end
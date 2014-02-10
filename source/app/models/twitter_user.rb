class TwitterUser < ActiveRecord::Base
  has_many :tweets
  before_save :set_refresh

  def set_refresh
    self.refresh_date = DateTime.now
  end

  def refresh_stale?
    Time.now - self.refresh_date > 600 ? true : false
  end

  def get_tweets
    if self.refresh_stale?
      self.tweet_refresh!
      self.tweets
    else
      self.tweets
    end
  end

  def tweet_refresh!
    new_tweets = $client.user_timeline(self.username)
    new_tweets.each do |tweet|
      new_tweet = Tweet.create(text: tweet.text, tweet_date: tweet.created_at)
      self.tweets << new_tweet
    end
  end
end

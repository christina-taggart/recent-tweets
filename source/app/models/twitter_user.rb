class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates :username, uniqueness: true

  def fetch_tweets!
    CLIENT.user_timeline(self.username).take(10).each do |tweet|
      tweet = Tweet.create(tweet_id: tweet.id.to_s, tweet_text: tweet.text, tweeted_at: tweet.created_at)
      self.tweets << tweet
    end
  end

  def tweets_stale?
    (Time.now - self.tweets.last.created_at)/60 > 15
  end

end

class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates :username, uniqueness: true

  def fetch_tweets!
    destroy_old_tweets

    CLIENT.user_timeline(self.username).take(10).each do |tweet|
      tweet = Tweet.create(tweet_id: tweet.id.to_s, tweet_text: tweet.text, tweeted_at: tweet.created_at)
      self.tweets << tweet
    end

  end

  def tweets_stale?
    avg_tweet_interval = (self.tweets.last.tweeted_at - self.tweets.first.tweeted_at)/self.tweets.length

    (Time.now - self.tweets.last.tweeted_at)/60 > avg_tweet_interval
  end

  def destroy_old_tweets
    self.tweets.destroy_all
  end

end

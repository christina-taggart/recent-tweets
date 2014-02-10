class TwitterUser < ActiveRecord::Base
  has_many :tweets
  before_save :set_refresh

  @intervals = [600]

  def set_refresh
    self.refresh_date = DateTime.now
  end

  def refresh_stale?
    Time.now - self.refresh_date > average_tweet_interval ? true : false
  end

  def average_tweet_interval
    update_intervals
    @intervals.reduce(:+) / @intervals.length
  end

  def update_intervals
    intervals = []
    20.times do |tweet|
      break unless self.tweets[tweet + 1]
      intervals << self.tweets[tweet].tweet_date - self.tweets[tweet + 1].tweet_date
    end
    @intervals = intervals
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

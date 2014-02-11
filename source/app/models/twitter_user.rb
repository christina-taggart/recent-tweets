require 'date'

class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def addTweets(tweets)
    self.tweets = tweets.map { |tweet| Tweet.create(text: tweet.text, created_at: tweet.created_at) }
    save
  end

  def fetch_tweets!(client)
    tweets = client.user_timeline(self.username, count: 10)
    self.last_fetched = Time.now
    addTweets(tweets)
    save
  end

  def tweet_stale?
    if last_fetched.nil?
      return true
    elsif first_tweet_is_nil?
      return true
    elsif caching_strategy
      return true
    else
      return false
    end
  end

  def first_tweet_is_nil?
    self.tweets.first.created_at.nil?
  end

  def caching_strategy
    avg_period = get_average_tweet_period
    (last_fetched < (Time.now - avg_period))
  end

  def get_average_tweet_period
    sorted_tweets = self.tweets.sort_by { |t| t.created_at }
    (sorted_tweets.last.created_at - sorted_tweets.first.created_at)/10
  end
end

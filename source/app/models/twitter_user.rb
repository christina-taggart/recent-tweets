class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def addTweets(tweets)
    tweets.each { |tweet| self.tweets << Tweet.create(text: tweet.text) }
  end

  def fetch_tweets!(client)
    tweets = client.user_timeline(self.username, count: 10)
    save
    addTweets(tweets)
  end
end

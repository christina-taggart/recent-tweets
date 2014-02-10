helpers do
  def authenticate
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  def build_user(username)
    new_user = TwitterUser.create(username: username)
    new_tweets = @client.user_timeline(username)
    new_tweets.each do |tweet|
      new_tweet = Tweet.create(text: tweet.text, tweet_date: tweet.created_at)
      new_user.tweets << new_tweet
    end
    new_user.save
    @tweets = new_user.tweets
  end
end
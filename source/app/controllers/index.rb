get '/' do
  erb :index
end

get '/:username' do
  @tweet_id = params[:username]
  @user = TwitterUser.find_by_username(params[:username])

  unless @user
    @user = TwitterUser.create(username: params[:username])
  end

  unless @user.tweet_stale?
    p "<<<<<<<<<<<<STILL RECENT USE CACHED"
    @tweets = @user.tweets.limit(10)
  else
    p "<<<<<<<<<<<<CACHE TOO OLD GET NEW"
    @user.fetch_tweets!(@client)
    @tweets = @user.tweets
  end
  erb :tweets_index
end

before do
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['OAUTH_TOKEN_SECRET']
  end
end

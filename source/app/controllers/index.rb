get '/' do
  erb :index
end

get '/:username' do
  p @client
  @tweets = @client.user_timeline(params[:username], count: 10)
  @tweet_id = params[:username]
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

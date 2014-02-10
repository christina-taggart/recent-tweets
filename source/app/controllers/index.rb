require 'twitter'

env_config = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))
env_config.each do |key, value|
  ENV[key] = value
end

$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['API_KEY']
  config.consumer_secret     = ENV['API_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

get '/' do
  "welcome to twitter"
end

get '/:username' do
  if TwitterUser.where(handle: params[:username]).empty?
    user = TwitterUser.create(handle: params[:username])
  else
    user = TwitterUser.where(handle: params[:username]).first
  end

  if user.tweets.empty?
    get_tweets(user)
  else
    @tweets = user.tweets.order(:date_made)
    if @tweets.last.date_made < Time.now - get_average_tweet_frequency(@tweets)
      @tweets.destroy_all
      get_tweets(user)
    end
  end
  erb :index
end




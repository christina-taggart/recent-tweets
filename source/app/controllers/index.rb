require 'twitter'

env_config = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))
env_config.each do |key, value|
  ENV[key] = value
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['API_KEY']
  config.consumer_secret     = ENV['API_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

# p ENV
# p ENV['API_SECRET']
# p ENV['ACCESS_TOKEN']
# p ENV['ACCESS_TOKEN_SECRET']

get '/' do
  "hi"
  # erb :index
end

get '/:username' do
  @tweets = client.user_timeline(params[:username])[0..9]
  erb :index
end


# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = ENV["CONSUMER_KEY"]
#   config.consumer_secret     = ENV["CONSUMER_SECRET"]
#   config.access_token        = ENV["ACCESS_TOKEN"]
#   config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
# end


client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "uup3hlNeWFRhxN6bqD0cA"
  config.consumer_secret     = "76MY8ws4vyHGatw0MJADhwrRuOfFhh9ked8mAPpPgIU"
  config.access_token        = "177408555-hz7bbGy54cfKmPr8seQcWQtNhnVVoDJLz5zUYmKf"
  config.access_token_secret = "f1DPIcuGebFoT3Cp2hgzbuROhvJQNn4QjfsAK17beAshE"
end

get '/' do
  erb :index
end

get '/:username' do
# @user = TwitterUser.find_by_username(params[:username])
#   if @user.tweets.empty?
#     # User#fetch_tweets! should make an API call
#     # and populate the tweets table
#     #
#     # Future requests should read from the tweets table
#     # instead of making an API call
#     @user.fetch_tweets!
#   end


  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield max_id
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def client.get_all_tweets(user)
    collect_with_max_id do |max_id|
      options = {:count => 200, :include_rts => true}
      options[:max_id] = max_id unless max_id.nil?
      user_timeline(user, options)
    end
  end

  handle = client.get_all_tweets(params[:username])
  @handle= handle.take(10)

  erb :index
end





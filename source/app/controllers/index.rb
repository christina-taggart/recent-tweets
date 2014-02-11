get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by_username(params[:username])
    if @user.tweets.empty?
      @user.fetch_tweets!
      #
      # Future requests should read from the tweets table
      # instead of making an API call
    end
    @tweets = @user.tweets.limit(10)
    erb :index
end









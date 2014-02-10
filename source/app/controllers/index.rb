get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by(username: params[:username])

  @user.fetch_tweets! if @user.tweets.length < 10
  @tweets = @user.tweets.limit(10)
  erb :usertweets
  
end

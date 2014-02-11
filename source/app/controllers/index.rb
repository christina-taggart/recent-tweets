get '/' do
  erb :index
end

get '/:username' do
  # @user = $client.user(params[:username])
  # p @user
  # @tweets = @user.tweets.limit(10)
  @tweets = $client.user_timeline(params[:username]).take(10)
  p @tweets
  p "**********************************************************"
  erb :tweets
end




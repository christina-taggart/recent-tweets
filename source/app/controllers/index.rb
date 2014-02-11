get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by(username: params[:username])

  begin
    @user.fetch_tweets! if @user.tweets.empty? || @user.tweets_stale?
    @tweets = @user.tweets.limit(10)
    erb :usertweets
  rescue

    erb :error
  end

end

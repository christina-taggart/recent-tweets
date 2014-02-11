get '/' do
  erb :index
end

get '/:username' do

  if User.find_by_handle(params[:username])
    @user = User.find_by_handle(params[:username])
    if @user.tweets_stale?
      tweets_to_delete = @user.tweets[0..9]
      tweets_to_delete.each {|tweet| tweet.destroy}
      tweets_from_twitter = $client.user_timeline(params[:username]).take(10)
      tweets_from_twitter.each do |tweet|
        Tweet.create(content: tweet.text, user_id: @user.id )
      end
    end

  else
    @user = User.create(handle: params[:username])
    tweets_from_twitter = $client.user_timeline(params[:username]).take(10)
    tweets_from_twitter.each do |tweet|
      Tweet.create(content: tweet.text, user_id: user.id )
    end
  end
  @tweets = @user.tweets
  p @tweets
  erb :tweets
end




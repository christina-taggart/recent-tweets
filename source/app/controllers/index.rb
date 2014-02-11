get '/' do
  erb :index
end

get '/:username' do

  if User.find_by_handle(params[:username])
    user = User.find_by_handle(params[:username])
  else
    user = User.create(handle: params[:username])
    tweets_from_twitter = $client.user_timeline(params[:username]).take(10)
    tweets_from_twitter.each do |tweet|
    Tweet.create(content: tweet.text, user_id: user.id )
    end
  end
  @tweets = user.tweets
  erb :tweets
end




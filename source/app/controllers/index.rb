get '/' do
  erb :index
end

post '/username' do
  redirect "/#{params[:username]}"
end

get '/:username' do
  @user = $client.user(params[:username].downcase)
  user = TwitterUser.create({twitter_id: @user.id, username: params[:username].downcase})
  if user.id.nil?
    # pull tweets from the DB to save time
    @benchmark_time = Benchmark.realtime {
      @tweets = TwitterUser.find_by_username(params[:username].downcase).tweets.take(10)
    }
  else
    # pull tweets from twitter api and save to DB
    @benchmark_time = Benchmark.realtime {
      @tweets = $client.user_timeline(user.twitter_id, {count: 10})
      @tweets.each do |tweet|
        Tweet.create({text: tweet.text, twitter_user_id: user.id})
      end
    }
  end

  @username = params[:username]
  @profile_background_image = @user.profile_background_image_url
  @profile_image = "http://pbs.twimg.com#{@user.profile_image_uri.request_uri}"
  erb :tweets
end

# $client.user_timeline(@user.id, {count: 10})
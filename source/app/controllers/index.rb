get '/' do
  erb :index
end

get '/username' do
  @user = params[:name]
  erb :tweets
end

post '/user' do
  TwitterUser.create(params)
  tweets = $client.user_timeline(@user, :count => 10)
  tweets.each do |tweet|
   Tweet.create(text: tweet.text)
  end
  @all_tweets = Tweet.where("name = #{params[:name]}")
  erb :tweets
end



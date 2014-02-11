require 'twitter'

get '/' do
  erb :index
end

get '/tweets' do
  CLIENT.user(params[:handle])
  @user = Twitteruser.find_or_create_by_handle(handle: params[:handle])
  redirect "/#{@user.handle}"
end

get '/:handle' do
  @user = Twitteruser.find_by_handle(params[:handle])
  if @user.tweets.empty? || Time.now - @user.tweets[0].created_at > 900
    @tweets = @user.fetch_tweets!
  else
    @tweets = @user.tweets
  end
  erb :tweets
end
get '/' do
  erb :index
end

post '/' do
  redirect "/#{params[:username]}"
end

get '/:username' do
  @user = TwitterUser.find_by_username(params[:username])
  if @user
    @tweets = @user.get_tweets
  else
    build_user(params[:username])
  end
  erb :index
end
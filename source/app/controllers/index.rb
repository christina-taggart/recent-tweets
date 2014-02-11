get '/' do
  erb :index
end

post '/username' do
  redirect "/#{params[:username]}"
end

get '/:username' do
  @user = $client.user(params[:username])
  @username = params[:username]
  @profile_background_image = @user.profile_background_image_url
  @profile_image = "http://pbs.twimg.com#{@user.profile_image_uri.request_uri}"
  p @profile_image
  erb :tweets
end


get '/' do
  erb :index
end

post '/username' do
  redirect "/#{params[:username]}"
end

get '/:username' do
  @user = $client.user(params[:username])
  @username = params[:username]
  erb :tweets
end


get '/' do
  erb :index
end

post '/' do
  redirect "/#{params[:username]}"
end

get '/:username' do
  client = authenticate
  @tweets = client.user_timeline(params[:username])
  erb :index
end
get '/' do
  erb :index
end

get '/:username' do
  client = authenticate
  @tweets = client.user_timeline(params[:username])
  erb :index
end
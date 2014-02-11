get '/' do
  erb :index
end

get '/username' do
  @user = params[:username]
  erb :tweets
end




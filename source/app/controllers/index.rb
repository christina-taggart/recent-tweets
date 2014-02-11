require 'twitter'
#include TwitterHelper

get '/' do
  # p get_client

  erb :index
end


get '/tweets' do
  CLIENT.user(params[:handle])
  @user = Twitteruser.find_or_create_by_handle(handle: params[:handle])
  redirect "/#{@user.handle}"
end

get '/:handle' do
  @user = Twitteruser.find_by_handle(params[:handle])
  if @user.tweets.empty?
    @tweets = @user.fetch_tweets!
  else
    puts "Hit the else branch"
    @tweets = @user.tweets
  end
  erb :tweets
end



  # def get_all_tweets(user)
  #     collect_with_max_id do |max_id|
  #     options = {:count => 200, :include_rts => false}
  #     options[:max_id] = max_id unless max_id.nil?
  #     client.user_timeline(user, options)
  #   end
  # end

  # def collect_with_max_id(collection=[], max_id=nil, &block)
  #   response = yield max_id
  #   collection += response
  #   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  # end
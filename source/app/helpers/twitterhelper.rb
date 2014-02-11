module TwitterHelper
# helpers do


  # client = Twitter::REST::Client.new do |config|
  #   config.consumer_key    = "Ecu7MkMMMhEo8Y8D13I5A"
  #   config.consumer_secret = "lvszfbKvpA4EzGnmN4g0aCQPQuSOfgsLBKTUGO9qaI"
  # end


  # def client.get_all_tweets(user)
  #     collect_with_max_id do |max_id|
  #     options = {:count => 200, :include_rts => false}
  #     options[:max_id] = max_id unless max_id.nil?
  #     user_timeline(user, options)
  #   end
  # end

  # def collect_with_max_id(collection=[], max_id=nil, &block)
  #   response = yield max_id
  #   collection += response
  #   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  # end

end
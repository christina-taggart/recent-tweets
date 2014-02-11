
class TwitterUser < ActiveRecord::Base
  # include PingTwitter
  has_many :tweets

CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key = "uup3hlNeWFRhxN6bqD0cA"
  config.consumer_secret = "76MY8ws4vyHGatw0MJADhwrRuOfFhh9ked8mAPpPgIU"
end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield max_id
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def CLIENT.get_all_tweets(user)
    collect_with_max_id do |max_id|
      options = {:count => 200, :include_rts => true}
      options[:max_id] = max_id unless max_id.nil?
      user_timeline(user, options)
    end
  end


  def fetch_tweets!
    tweets = CLIENT.get_all_tweets(username)
    tweets.each do |tweet|
      self.tweets << Tweet.create(tweet_text: tweet.text)
    end

  end

end

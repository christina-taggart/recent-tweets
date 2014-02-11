class User < ActiveRecord::Base
  has_many :tweets

  # def self.find_user(args)
  #   User.find_by_handle(args)
  # end

  # # def self.create_user(args)
  # #   User.create(handle: args)
  # # end

  # def self.set_user_from_twitter(user_from_db)
  #   user_from_twitter = $client.user(user_from_db.handle)
  # end

  # def self.get_10_tweets(args)
  #   tweets_from_twitter = $client.user_timeline(args).take(10)
  # end

  # def self.create_tweet_db(tweets_from_twitter)
  #   tweets_from_twitter.each do |tweet|
  #     Tweet.create(content: tweet.text, user_id: user.id )
  #   end
  # end

end



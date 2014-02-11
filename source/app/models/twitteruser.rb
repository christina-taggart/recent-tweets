class Twitteruser < ActiveRecord::Base
  has_many :tweets
  validates :handle, uniqueness: true

  #include TwitterHelper
  # def tweets
  #   # @tweets = client.


  # end

  def fetch_tweets!
    @tweets = CLIENT.user_timeline(self.handle).take(10)
    p @tweets
    @tweets.each {|tweet| self.tweets << Tweet.create(text: tweet.text, tweeted_at: tweet.created_at)}
    @tweets
  end

end

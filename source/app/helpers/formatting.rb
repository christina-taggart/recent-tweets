helpers do


  def em(text)
    "<em>#{text}</em>"
  end

  def get_tweets(user)
    @tweets = $client.user_timeline(params[:username])
    @tweets.each do |tweet|
      tweet = Tweet.create(text: tweet.text, date_made: tweet.created_at)
      user.tweets << tweet
    end
  end

  def get_average_tweet_frequency(tweets)
    first_tweet = tweets.last
    last_tweet = tweets.first
    [first_tweet,last_tweet].map{|x| Time.parse(x.date_made.to_s).to_f}.inject(:-)/10
  end
end



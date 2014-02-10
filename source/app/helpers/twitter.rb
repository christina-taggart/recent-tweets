helpers do
  def build_user(username)
    new_user = TwitterUser.create(username: username)
    begin
      new_user.tweet_refresh!
      @tweets = new_user.tweets
    rescue Twitter::Error::NotFound => error
      @error = "Sorry, that user does not exist."
    end
  end
end
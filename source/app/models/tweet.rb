class Tweet < ActiveRecord::Base
  # include PingTwitter
  belongs_to :twitter_user
  # Remember to create a migration!
end

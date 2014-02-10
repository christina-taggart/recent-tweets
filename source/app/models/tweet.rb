class Tweet < ActiveRecord::Base
  belongs_to :twitter_users
end

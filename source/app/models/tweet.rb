class Tweet < ActiveRecord::Base
  belongs_to :twitter_user
  validates :text, uniqueness: true
end

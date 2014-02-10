class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |col|
      col.belongs_to :twitter_user
      col.string :text
      col.datetime :tweet_date
    end
  end
end

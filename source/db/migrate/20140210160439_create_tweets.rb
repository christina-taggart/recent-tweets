class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |col|
      col.belongs_to :twitter_user
      col.string :tweet_text
      col.timestamps
    end
  end
end

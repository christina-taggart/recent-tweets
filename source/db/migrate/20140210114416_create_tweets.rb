class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user
      t.string :tweet_id
      t.string :tweet_text
      t.datetime :tweeted_at
      t.timestamps
    end
  end
end

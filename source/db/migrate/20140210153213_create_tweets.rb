class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitteruser
      t.string :text
      t.string :tweeted_at

      t.timestamps
    end
  end
end

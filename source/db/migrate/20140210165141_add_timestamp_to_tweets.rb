class AddTimestampToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :created_at, :datetime
  end
end

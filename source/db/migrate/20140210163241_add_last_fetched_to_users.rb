class AddLastFetchedToUsers < ActiveRecord::Migration
  def change
    add_column :twitter_users, :last_fetched, :datetime
  end
end

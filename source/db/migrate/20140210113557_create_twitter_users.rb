class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :username
      t.datetime :refresh_date
      t.timestamps
    end
  end
end

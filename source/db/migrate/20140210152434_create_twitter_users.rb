class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |col|
      col.string :username
      col.timestamps
    end
  end
end

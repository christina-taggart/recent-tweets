class CreateTwitterusers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.integer :twitter_id
      t.string :username

      t.timestamps
    end
  end
end

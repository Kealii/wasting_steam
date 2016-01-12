class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :user_name
      t.string :twitter_name
      t.string :steam_id

      t.timestamps null: false
    end
  end
end

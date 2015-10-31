class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :bet_id

      t.timestamps null: false
    end
    add_index :likes, :user_id
    add_index :likes, :bet_id
    add_index :likes, [:user_id, :bet_id], unique: true
  end
end

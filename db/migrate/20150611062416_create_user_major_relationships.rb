class CreateUserMajorRelationships < ActiveRecord::Migration
  def change
    create_table :user_major_relationships do |t|
      t.integer :user_id
      t.integer :major_id

      t.timestamps null: false
    end

    add_index :user_major_relationships, :user_id
    add_index :user_major_relationships, :major_id
    add_index :user_major_relationships, [:user_id, :major_id], unique: true
  end
end

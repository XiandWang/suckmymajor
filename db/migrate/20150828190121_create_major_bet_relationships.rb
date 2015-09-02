class CreateMajorBetRelationships < ActiveRecord::Migration
  def change
    create_table :major_bet_relationships do |t|
      t.integer :bet_id
      t.integer :major_id

      t.timestamps null: false
    end

    add_index :major_bet_relationships, :bet_id
    add_index :major_bet_relationships, :major_id
    add_index :major_bet_relationships, [:major_id, :bet_id], unique: true
  end
end

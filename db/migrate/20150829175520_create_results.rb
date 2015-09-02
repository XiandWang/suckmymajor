class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :bet_id
      t.integer :winner_id
      t.integer :loser_id

      t.timestamps null: false
    end

    add_index :results, :bet_id
    add_index :results, :winner_id
    add_index :results, :loser_id
  end
end

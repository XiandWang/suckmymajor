class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :status
      t.boolean :lying
      t.text :proof
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :bets, :users
    add_index :bets, [:user_id, :created_at]
  end
end

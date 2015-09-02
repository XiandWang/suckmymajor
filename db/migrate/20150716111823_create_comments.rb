class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user, index: true, null: false
      t.references :bet, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :comments, :users
    add_foreign_key :comments, :bets
  end
end

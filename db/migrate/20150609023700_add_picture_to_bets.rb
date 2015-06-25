class AddPictureToBets < ActiveRecord::Migration
  def change
    add_column :bets, :picture, :string
  end
end

class RemovePictureFromBets < ActiveRecord::Migration
  def change
    remove_column :bets, :picture, :string
  end
end

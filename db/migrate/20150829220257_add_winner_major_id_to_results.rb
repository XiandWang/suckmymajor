class AddWinnerMajorIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :winner_major_id, :integer
  end
end

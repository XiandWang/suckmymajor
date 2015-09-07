class AddBetIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :bet_id, :integer
  end
end

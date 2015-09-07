class AddIndexToNotifications < ActiveRecord::Migration
  def change
    add_index :notifications, :bet_id
  end
end

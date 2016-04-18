class AddHiddenToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :hidden, :boolean, default: false
  end
end

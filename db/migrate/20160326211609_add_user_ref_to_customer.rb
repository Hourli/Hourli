class AddUserRefToCustomer < ActiveRecord::Migration
  def change
    add_reference :customers, :user, index: true, foreign_key: true, null: true
  end
end

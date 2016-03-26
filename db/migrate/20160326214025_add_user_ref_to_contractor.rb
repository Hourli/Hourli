class AddUserRefToContractor < ActiveRecord::Migration
  def change
    add_reference :contractors, :user, index: true, foreign_key: true, null: true
  end
end

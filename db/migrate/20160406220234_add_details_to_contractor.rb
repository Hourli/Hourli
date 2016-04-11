class AddDetailsToContractor < ActiveRecord::Migration
  def change
    add_column :contractors, :occupation, :string
    add_column :contractors, :location, :string
    add_column :contractors, :summary, :string
  end
end

class AddZipCodeAndPinIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :pin_id, :integer
    add_column :orders, :zip_code, :string
  end
end

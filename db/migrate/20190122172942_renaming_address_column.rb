class RenamingAddressColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :ads, :adress, :address
  end
end

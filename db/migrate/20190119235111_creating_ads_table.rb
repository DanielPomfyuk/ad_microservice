class CreatingAdsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :adress
      t.column :real_estate_type, :integer, default: 0
      t.integer :rooms
      t.float :square
    end
  end
end

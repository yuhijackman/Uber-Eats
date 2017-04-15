class AddColomnToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :likes_count, :integer
  end
end

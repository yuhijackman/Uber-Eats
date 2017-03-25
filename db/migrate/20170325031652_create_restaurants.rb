class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :email
      t.text :address
      t.string :genre
      t.text :image
      t.timestamps
    end
  end
end

class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.string :price
      t.text :detail
      t.text :image
      t.references :restaurant, foreign_key: true
    end
  end
end

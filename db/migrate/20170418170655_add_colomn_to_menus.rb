class AddColomnToMenus < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :status, :integer
  end
end

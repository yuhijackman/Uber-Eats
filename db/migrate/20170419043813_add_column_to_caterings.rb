class AddColumnToCaterings < ActiveRecord::Migration[5.0]
  def change
    add_column :caterings, :address, :text
  end
end

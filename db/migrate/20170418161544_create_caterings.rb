class CreateCaterings < ActiveRecord::Migration[5.0]
  def change
    create_table :caterings do |t|
      t.references :user, foreign_key: true
      t.references :menu, foreign_key: true
      t.datetime :arrived_at, null: false
      t.timestamps
    end
  end
end

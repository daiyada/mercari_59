class ChangeColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :saler, :references, null: false, foreign_key: true
    add_column :items, :buyer, :references, foreign_key: true
    remove_column :items, :user
  end
end

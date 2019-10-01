class ChangeColumnToItems < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :user, foreign_key: true

    add_column :items, :buyer_id, :integer, null: false
    add_column :items, :seller_id, :integer, null: false
  end
end

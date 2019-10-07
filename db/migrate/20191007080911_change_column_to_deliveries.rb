class ChangeColumnToDeliveries < ActiveRecord::Migration[5.2]
  def change
    add_reference :deliveries, :item, foreign_key: true, null: false
    # remove_column :deliveries, :item_id, null: false
    # remove_reference :deliveries, :item, foreign_key: true, null: false
  end
end

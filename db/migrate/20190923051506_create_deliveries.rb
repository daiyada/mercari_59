class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.string :pay_for_shipping,       null: false
      t.string :delivery_from,          null: false
      t.string :due_time_day,           null: false
      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user,         foreign_key: true, null: false
      t.references :category,     foreign_key: true, null: false
      t.string :name,             null: false, index: true
      t.text :descript,           null: false
      t.string :condition,        null: false
      t.integer :price,           null: false
      t.integer :stock_status,    null: false
      t.string :size,             null: false
      t.string :brand
      t.timestamps
    end
  end
end

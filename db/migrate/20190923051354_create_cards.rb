class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :number,                   null: false, unique: true
      t.string :expiration_date_year,     null: false
      t.string :expiration_date_month,    null: false
      t.string :security_code,            null: false
      t.timestamps
    end
  end
end

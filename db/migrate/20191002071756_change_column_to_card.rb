class ChangeColumnToCard < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :number, :string
    remove_column :cards, :expiration_date_year, :string
    remove_column :cards, :expiration_date_month, :string
    remove_column :cards, :security_code, :string

    add_reference :cards, :user, foreign_key: true, null: false
    add_column :cards, :customer_id, :string, null: false
  end
end

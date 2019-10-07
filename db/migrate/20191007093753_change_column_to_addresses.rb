class ChangeColumnToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :user, foreign_key: true, null: false
  end
end

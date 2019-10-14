class Address < ApplicationRecord
  belongs_to :user

  #STEP3入力項目validation
  validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :address, presence: true
  # validates :building
  # validates :phone_number
end

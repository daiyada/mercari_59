class Address < ApplicationRecord
  belongs_to :user

  #STEP3入力項目validation
  with_options presence: true do
    validates :postal_code
    validates :prefecture
    validates :city
    validates :address
  end
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
end

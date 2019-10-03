class Item < ApplicationRecord

  has_many :images, dependent: :destroy
  has_one :delivery, dependent: :destroy
  belongs_to :category
  belongs_to :user
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"

end

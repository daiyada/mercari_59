class Item < ApplicationRecord
  has_many :images
  has_one :delivery
  belongs_to :category
  belongs_to :saler, class_name: "User"
  belongs_to :buyer, class_name: "User"
end

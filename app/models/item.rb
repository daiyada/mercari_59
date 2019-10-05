class Item < ApplicationRecord

  has_many :images ,inverse_of: :item #, dependent: :destroy
  has_one :delivery, dependent: :destroy
  belongs_to :category
  
  # belongs_to :saler, class_name: "User"
  # belongs_to :buyer, class_name: "User"
  accepts_nested_attributes_for :images
end

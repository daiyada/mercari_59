class Item < ApplicationRecord
  has_many :images
  belongs_to :user
  belongs_to :category
  has_one :delivery
end

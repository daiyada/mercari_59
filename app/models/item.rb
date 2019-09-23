class Item < ApplicationRecord
  ham_many :images
  belongs_to :user
  belongs_to :category
  has_one :delivery
end

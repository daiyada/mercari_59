class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  belongs_to :category
  has_one :delivery, dependent: :destroy
end

class Item < ApplicationRecord

  has_many :images ,inverse_of: :item ,dependent: :destroy
  has_one :delivery ,dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :images

end
class Delivery < ApplicationRecord
  # belongs_to :item
  has_one :item
end

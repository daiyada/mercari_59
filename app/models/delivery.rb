class Delivery < ApplicationRecord
  # belongs_to :item
  has_one :item ,dependent: :destroy
end

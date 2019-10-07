class Delivery < ApplicationRecord
  # belongs_to :item
  belongs_to :item ,dependent: :destroy
end

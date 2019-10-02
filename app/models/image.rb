class Image < ApplicationRecord
  belongs_to :item ,dependent: :destroy
end

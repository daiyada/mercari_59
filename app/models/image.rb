class Image < ApplicationRecord
  belongs_to :item , inverse_of: :images #,optional: true #,dependent: :destroy
  mount_uploaders :image, ImageUploader
end

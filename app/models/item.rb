class Item < ApplicationRecord

  has_many :images ,inverse_of: :item #, dependent: :destroy
  has_one :delivery, dependent: :destroy
  belongs_to :category
  
  # belongs_to :seller, class_name: "User"
  # belongs_to :buyer, class_name: "User"
  accepts_nested_attributes_for :images

  def seller(current_user)
    self.where("(seller_id = ?) and (buyer_id = ?)",current_user, 0)
  end
end

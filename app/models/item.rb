class Item < ApplicationRecord

  has_many :images ,inverse_of: :item #, dependent: :destroy
  has_one :delivery, dependent: :destroy
  belongs_to :category
  
  # belongs_to :seller, class_name: "User"
  # belongs_to :buyer, class_name: "User"
  accepts_nested_attributes_for :images

  def can_purchase
    if @item.seller_id != current_user
      if @item.buyer_id == 0 ||  @item.buyer_id.blank?
        true
      else
        false
      end
    end
  end

end

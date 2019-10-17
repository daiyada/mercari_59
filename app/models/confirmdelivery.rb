class Confirmdelivery
  def self.confirmdel
    itemlast_id = Item.last.id 
    thisdeli = Delivery.where(item_id: itemlast_id)[0]
      if thisdeli&.id == nil
      cancel_item = Item.find(itemlast_id)
      cancel_item.destroy
      return false
      end
    return true
  end
end
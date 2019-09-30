class ItemsController < ApplicationController
  def index
    
  end
  def new
    @item = Item.new
    # @image = Image.new
    # @deliverrie = Delivery.new
  end
  def create

    item = Item.new(item_params) 
    delivery = Delivery.new(delivery_params)
    image = Image.new(image_params) 
    validate = [image.image , item.name , item.descript , item.condition , item.price , delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day ]
    unless validate.include?(""||nil)
      item.save  
      image.save
      delivery.save
      redirect_to controller: :items, action: :index
    else
    # render :new
    # redirect_to controller: :items, action: :new
    end
 
  end
  def show
  end
  def purchase
  end
  private
  def item_params
    params.require(:item).permit(:name,:descript,:condition,:price).merge(user_id: 1,stock_status: 1, category_id: 3, size:"M")
  end
  def image_params
    item_id = Item.last
    if item_id == nil
      item_id =1 
    else
      item_id = item_id.id + 1
    end
    params.require(:image).permit(:image).merge(item_id: item_id)
  end
  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end
end

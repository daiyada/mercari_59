class ItemsController < ApplicationController
  def index
    
  end
  def new
    @item = Item.new
    @image = Image.new
    # @categorie = Category.new
    @deliverrie = Delivery.new
  end
  def create
    params_of_item = item_params
    params_of_image = image_params
    params_of_delivery = delivery_params
    # binding.pry
    item = Item.new(params_of_item) 
    
  
    delivery = Delivery.new(params_of_delivery)
    image = Image.new(params_of_image) 
    image.save
    delivery.save
      binding.pry
    if  item.save
      redirect_to controller: :items, action: :index
    else  
      render :new
    end
      # item = Item.create(:item params[:id])
    # item.images.create(:item params[:id],:image params[:image])
    # item.categorie.create(:ancestory params[:ancestory],:name params[:name])
    # item.deliverrie.create(:due_time_day params[:due_time_day],:delivery_from params[:delivery_from], :due_time_day params[:due_time_day])
    # redirect_to controller: :items, action: :new
  end
  def show
  end
  def purchase
  end
  private
  def item_params
    # params.require(:group).permit(:name, { :user_ids => [] })
    # params.permit(:image, :text)
    params.require(:item).permit(:name,:descript,:condition,:price).merge(user_id: 1,stock_status: 1, category_id: 3, size:"M")
    # (user_id: current_user.id)
    
    # binding.pry
  end
  def image_params
    item_id = Item.last
    item_id = item_id.id.to_i + 1 
    params.require(:image).permit(:image).merge(item_id: item_id.to_s)
  end
  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
    # binding.pry
  end
end

class ItemsController < ApplicationController
  def index
    #  @images = Image.last.includes(:item).per(10).order("created_at DESC")
     @image = Image.last
  end
  def new
    @item = Item.new
    @item.images.build
    @category = Category.all
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
    end
  end
  def create

        item_id = Item.last
        item_id == nil ? item_id =1 : item_id = item_id.id + 1
    item = Item.new(item_params) 
    
    delivery = Delivery.new(delivery_params)
    params[:item][:images_attributes] == nil ? pic_exist = nil : pic_exist = 1 

    validate = [ pic_exist, item.name , item.descript , item.condition , item.price ,item.category_id, delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day ]
    
    unless validate.include?("") || validate.include?(nil)
      item.save  
      delivery.save
 
      redirect_to controller: :items, action: :index
    else
    # render :new
    # redirect_to controller: :items, action: :new
    end
  end
  def get_category_children 
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
 end

  def show
  end
  def purchase
  end
  private
  def item_params
    ancestry_pass = params.require(:grandchild_id) rescue
    ancestry_pass =nil if ancestry_pass == "---" || ancestry_pass == nil || ancestry_pass == "" 
    params.require(:item).permit(:name,:descript,:condition,:price, images_attributes: {image: []} ).merge(buyer_id: 0, seller_id: 1,stock_status: 1, category_id: ancestry_pass, size:"M")
  end

  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end
end

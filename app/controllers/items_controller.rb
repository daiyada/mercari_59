class ItemsController < ApplicationController
  def index
     @images = Image.includes(:item).per(10).order("created_at DESC")
    
  end
  def new
    @item = Item.new
    @item.images.build
    @category = Category.all
    category = Category.where(ancestry: nil)
    @category_parent_array = category.pluck(:name).unshift("---")
  end
  def create

    item_id = Item.last
    item_id == nil ? item_id =1 : item_id = item_id.id + 1
    item = Item.new(item_params) 
    image_params_pics = params[:item][:images_attributes][:"0"][:image] rescue
    image = Image.new(item_id: item_id) 
    image.image = image_params_pics[0] unless image_params_pics = ""
    delivery = Delivery.new(delivery_params)

    validate = [ image.image, item.name , item.descript , item.condition , item.price ,item.category_id, delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day ]
    unless validate.include?("") || validate.include?(nil)
      item.save  
      image.save
      delivery.save
      image_params_pics.drop(1).each do |photo|
        image = Image.new(image: photo, item_id: item_id) unless photo == ""
        image.save
      end
      redirect_to controller: :items, action: :index
    
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
    params.require(:item).permit(:name,:descript,:condition,:price ).merge(buyer_id: 0, seller_id: 1,stock_status: 1, category_id: ancestry_pass, size:"M")
  end

  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end
end

class ItemsController < ApplicationController
  def index
    
  end
  def new
    @item = Item.new
    # @image = Image.new
    # @deliverrie = Delivery.new
    @category = Category.all
    #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
    end
  end
  def create
    # binding.pry
    item = Item.new(item_params) 
    delivery = Delivery.new(delivery_params)

    item_id = Item.last
    item_id == nil ? item_id =1 : item_id = item_id.id + 1
    image_params_pics = image_params.compact.reject(&:empty?)
    image = Image.new(image: image_params[0] , item_id: item_id) 
    
    
    validate = [image.image , item.name , item.descript , item.condition , item.price , delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day ]
    unless validate.include?(""||nil)
      item.save  
      image.save
      delivery.save
      image_params_pics.drop(1).each do |photo|
      image = Image.new(image: photo, item_id: item_id) unless photo == ""
      image.save
        end
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
    # params.require(:image).permit(:image1,:image2,:image3,:image4,:image5,:image6,:image7,:image8,:image9,:image10).merge(item_id: item_id)
    params.require(:image)
    # params.require(:image).permit({image: []}).merge(item_id: item_id)
  end
  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end
end

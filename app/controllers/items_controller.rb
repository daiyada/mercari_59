class ItemsController < ApplicationController
  def index
     # @images = Image.includes(:item).per(10).order("created_at DESC")
     @image = Image.find(14)
  end
  def new
    @item = Item.new
    @item.images.build
    # @image = Image.new



    @category = Category.all
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
    end
  end
  def create


    # binding.pry
        item_id = Item.last
        item_id == nil ? item_id =1 : item_id = item_id.id + 1
    item = Item.new(item_params) 
    
    # item.save
    
    delivery = Delivery.new(delivery_params)
    params[:item][:images_attributes] == nil ? pic_exist = nil : pic_exist = 1 

    validate = [ pic_exist, item.name , item.descript , item.condition , item.price ,item.category_id, delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day ]
    binding.pry
    unless validate.include?("") || validate.include?(nil)
      item.save  
      # image.save
      delivery.save
     
      # image_params_pics.drop(1).each do |photo|
      # image = Image.new(image: photo, item_id: item_id) unless photo == ""
      # image.save
      
      #   end
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
    # binding.pry
  end
  def image_params
    # params.require(:image).permit(:image1,:image2,:image3,:image4,:image5,:image6,:image7,:image8,:image9,:image10).merge(item_id: item_id) images_attributes: [:image]
    # params.require(:image)
    
    params.require(:image) 
    
    # .merge(item_id: item_id) 
  end
  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end
end

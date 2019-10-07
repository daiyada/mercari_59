class ItemsController < ApplicationController
  def index
    category_Nos = Category.where(ancestry: nil)
   border_No=[]
   category_Nos.each do |category_No|
   num = category_No.id
   border_No << num
   end
    # .where('model LIKE(?)', "%#{a_model}%")
   @radies = Item.where("category_id <= ?", border_No[1]).order("created_at DESC")
  #  .where("id > ?", 5) #{border_No[1]}

  #  binding.pry
  #  @radies.each do |rady|
  #  image = rady.images.first

  #  binding.pry
  #  end
  #  .where('model LIKE(?)', "%#{a_model}%")
    # @images = Image.order("created_at DESC")
    # @image = Image.last
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
    delivery = Delivery.new(delivery_params)
    pic_pass = params[:item][:images_attributes]
    
    validate = [pic_pass, item.name , item.descript , item.condition , item.price ,item.category_id, delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day ]
    unless validate.include?("") || validate.include?(nil)
      item.save  
      delivery.save
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
    @item = Item.find(1)    #1→params[:id]に変更する。show.html.hamlでeachで取り出すようにする
    @category = @item.category
    @image =  @item.images
    @delivery = @item.delivery
  end

  def purchase

  end

  private
  def item_params  
    ancestry_pass = params.require(:grandchild_id) rescue
    ancestry_pass =nil if ancestry_pass == "---" || ancestry_pass == nil || ancestry_pass == "" 
    params.require(:item).permit(:name,:descript,:condition,:price,images_attributes: [:image] ).merge(buyer_id: 0, seller_id: 1,stock_status: 1, category_id: ancestry_pass, size:"M")
    # images_attributes: {image: []}
  end

  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end
end

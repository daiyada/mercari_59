class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :purchase, :pay]
  
  def index
    category_No = Category.where(ancestry: nil)
    border_No = category_No.pluck(:id)
    @radies = Item.where(category_id: 1...border_No[1]).order("created_at DESC").limit(10)
    @mens = Item.where(category_id: border_No[1]...border_No[2]).order("created_at DESC").limit(10)
    @kadens = Item.where(category_id: border_No[7]...border_No[8]).order("created_at DESC").limit(10)
    category = Category.where(ancestry: nil)
    @category = category.pluck(:name)
    params[:keyword].to_i == 0 ? grandchild_id =100 : grandchild_id = params[:keyword].to_i
    @grandchildren = Category.find(grandchild_id).children
    respond_to do |format|
      format.html
      format.json
    end
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
    delivery.item_id = item_id
    pic_pass = params[:item][:images_attributes]
    validate = [pic_pass, item.name , item.descript , item.condition , item.price ,item.category_id, delivery.pay_for_shipping , delivery.delivery_from , delivery.due_time_day, delivery.item_id ]
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
    @id = current_user.id
    @seller = @item.seller(@id)
    @category = @item.category
    @image = @item.images
    @delivery = @item.delivery
    @nickname = User.find(@item.seller_id).nickname
  end

  def purchase
    @user = User.find(current_user.id)
    @card = @user.card
    @address = User.find(current_user.id).address
    @image = @item.images
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @cards = customer[:cards][:data][0]
  end

  def pay
    card = Card.where(user_id: current_user.id)[0]
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    Payjp::Charge.create(
    amount: @item.price,
    customer: card.customer_id,
    currency: "jpy"
    )
    @item.buyer_id = 1
    @item.save
    redirect_to item_path(@item)
  end

  private
  def item_params  
    ancestry_pass = params.require(:grandchild_id) rescue
    ancestry_pass = nil if ancestry_pass == "---" || ancestry_pass == nil || ancestry_pass == "" 
    validate_price = params[:item][:price].to_i
    validate_price = nil if validate_price < 300
    params.require(:item).permit(:name,:descript,:condition,images_attributes: [:image] ).merge(price: validate_price , buyer_id: 0, seller_id: 1,stock_status: 1, category_id: ancestry_pass, size:"M")
  end

  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

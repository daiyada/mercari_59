class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :purchase, :pay ,:destroy]
  before_action :set_navi, only: [:show,:index,:show, :purchase, :pay]
  def index
    category_No = Category.where(ancestry: nil)
    border_No = category_No.pluck(:id)
    @radies = Item.where(category_id: 1...border_No[1]).order("created_at DESC").limit(10)
    @mens = Item.where(category_id: border_No[1]...border_No[2]).order("created_at DESC").limit(10)
    @kadens = Item.where(category_id: border_No[7]...border_No[8]).order("created_at DESC").limit(10)
    params[:keyword].to_i == 0 ? grandchild_id =100 : grandchild_id = params[:keyword].to_i
    @grandchildren = Category.find(grandchild_id).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    redirect_to sign_in_path unless user_signed_in?
    @item = Item.new
    @item.images.build
    @category = Category.all
    category = Category.where(ancestry: nil)
    @category_parent_array = category.pluck(:name).unshift("---")
  end

  def edit
    redirect_to sign_in_path unless user_signed_in?
    @item = Item.find( params[:id])
    @item.images.build
    @delivery = Delivery.find( params[:id])
    @category = Category.all
    category = Category.where(ancestry: nil)
    @category_parent_array = category.pluck(:name).unshift("---")
    @grandchild = @item.category
    @images = Image.where(item_id: params[:id])
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
      redirect_to root_path
    else
      redirect_to action: :new 
    end
  end
  
  def update
    item = Item.find(params[:id])
    category_id =""
    category_id = params[:grandchild_id] rescue
    price = params[:item][:price]
    params[:item][:price].to_i >= 300 ? price = params[:item][:price] : price = nil
    validate = [ params[:item][:name] , params[:item][:descript]  , price ,category_id ]
    unless validate.include?("") || validate.include?(nil)
    item.update(params.require(:item).permit(:name, :descript, :condition, :price).merge(category_id: category_id))
    delivery = Delivery.where(item_id: params[:id])
    delivery.update(params.require(:delivery).permit(:pay_for_shipping, :delivery_from, :due_time_day))
    redirect_to item
    else
    redirect_to action: :edit
    end
  end

  def get_category_children 
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end
  
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def show
    @category = @item.category
    @image = @item.images
    @delivery = @item.delivery
    @nickname = User.find(@item.seller_id).nickname
  end

  def purchase
    if not user_signed_in?
      redirect_to sign_in_path
    elsif @card.nil?
      redirect_to new_card_path
    else
    @user = current_user
    @card = @user.card
    @address = @user.address
    @image = @item.images
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @cards = customer[:cards][:data][0]
    end
  end

  def pay
    redirect_to sign_in_path unless user_signed_in?
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

  def destroy
    redirect_to sign_in_path unless user_signed_in?
    if @item.destroy
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", notice: "削除に失敗しました"
    end
  end

  private
  def item_params  
    ancestry_pass = params.require(:grandchild_id) rescue
    ancestry_pass = nil if ancestry_pass == "---" || ancestry_pass == nil || ancestry_pass == "" 
    validate_price = params[:item][:price].to_i
    validate_price = nil if validate_price < 300
    params.require(:item).permit(:name,:descript,:condition,images_attributes: [:image] ).merge(price: validate_price , buyer_id: 0, seller_id: current_user.id,stock_status: 1, category_id: ancestry_pass, size:"M")
  end

  def delivery_params
    params.require(:delivery).permit(:pay_for_shipping,:delivery_from,:due_time_day)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_navi
    navicategory = Category.where(ancestry: nil)
    @navicategory = navicategory.pluck(:name)
  end
end

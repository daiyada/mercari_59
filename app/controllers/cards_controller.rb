class CardsController < ApplicationController
  before_action :set_navi, only: [:edit,:show,:new,:create,:destroy]
  before_action :set_user, only: [:edit,:show,:new,:create,:destroy]

  def show
    card = current_user.card
      if card.present?
        Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
        customer = Payjp::Customer.retrieve(card.customer_id)
        @card = customer[:cards][:data][0]
      else
        redirect_to new_card_path
      end
  end

  def edit
  end

  def new
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer.create(card: params[:payjpToken])
    @card = Card.create(user_id: current_user.id, customer_id: customer.id, card_id: params[:payjpToken])
    if @card.blank?
      redirect_to edit_card_path
    else
      redirect_to card_path(@card)
    end
  end

  def destroy
    card = Card.where(user_id: current_user.id)[0]
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer.retrieve(card.customer_id)
    if card.user_id == current_user.id
      card.delete
      customer.delete
      redirect_to action: "new"
    else
      redirect_to action: "logout"
    end
  end
  private
  def set_navi
    navicategory = Category.where(ancestry: nil)
    @navicategory = navicategory.pluck(:name)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end

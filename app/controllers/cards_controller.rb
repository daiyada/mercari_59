class CardsController < ApplicationController
  def show
  end

  def edit
  end

  def new
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer.create(card: params[:payjpToken])
    @card = Card.new(user_id: current_user&.id, customer_id: customer.id, card_id: params[:payjpToken])
    if @card.blank?
      redirect_to "/cards/1/edit"
    else
      redirect_to "/cards/1/"
    end
  end
end

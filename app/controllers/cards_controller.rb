class CardsController < ApplicationController

  def show
    card = Card.where(user_id: 1)[0]
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
    @card = Card.create(user_id: 1, customer_id: customer.id, card_id: params[:payjpToken])
    if @card.blank?
      redirect_to "/cards/1/edit"
    else
      redirect_to "/cards/1/"
    end
  end

  def destroy
  end
end

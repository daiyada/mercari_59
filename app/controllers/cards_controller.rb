class CardsController < ApplicationController
  def show
  end

  def edit
  end

  def new
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer
    binding.pry
  end
end

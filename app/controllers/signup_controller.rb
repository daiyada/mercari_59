class SignupController < ApplicationController
  before_action :validates_step1, only: :step2
  before_action :validates_step2, only: :step3
  before_action :validates_step3, only: :step4

  def step1
    @user = User.new
  end

  def step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:name_family] = user_params[:name_family]
    session[:name_family_kana] = user_params[:name_family_kana]
    session[:name_first] = user_params[:name_first]
    session[:name_first_kana] = user_params[:name_first_kana]
    @user = User.new
  end

  def step3
    session[:cellphone_number] = user_params[:cellphone_number]
    @user = User.new
    @user.build_address
  end

  def step4
    session[:address_attributes] = user_params[:address_attributes]
    @user = User.new
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_family_kana:session[:name_family_kana],
      name_first: session[:name_first],
      name_first_kana: session[:name_first_kana],
      cellphone_number: session[:cellphone_number]
    )
    @user.build_address(
      session[:address_attributes]
    )

    Payjp.api_key = Rails.application.credentials.dig(:payjp,:PAYJP_SECRET_KEY)
    customer = Payjp::Customer.create(card: params[:payjpToken])
    @card = Card.new(user_id: @user.id, customer_id: customer.id, card_id: params[:payjpToken])
    if @card.save
      if @user.save
        session[:id] = @user.id
        redirect_to done_signup_index_path
      else
        card = Card.where(user_id: @user.id)
        card.destroy
        render '/users/new'
      end
    else
      render '/signup/step4'
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

def validates_step1
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:name_family] = user_params[:name_family]
    session[:name_family_kana] = user_params[:name_family_kana]
    session[:name_first] = user_params[:name_first]
    session[:name_first_kana] = user_params[:name_first_kana]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_first: session[:name_first], 
      name_family_kana: session[:name_family_kana], 
      name_first_kana: session[:name_first_kana],
      cellphone_number: "090-1234-5678"
    )
    render '/signup/step1' unless @user.valid?
  end

  def validates_step2
    session[:cellphone_number] = user_params[:cellphone_number]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_first: session[:name_first], 
      name_family_kana: session[:name_family_kana], 
      name_first_kana: session[:name_first_kana],
      cellphone_number: session[:cellphone_number]
    )
    @address = @user.build_address(
      postal_code: "123-4567",
      prefecture: "神奈川県",
      city: "横浜市緑区",
      address: "青山1-1-1",
      building: "柳ビル103",
      phone_number: "090-1234-5678" 
    )
    render '/signup/step2' unless @user.valid?
  end

  def validates_step3
    session[:postal_code] = user_params[:postal_code]
    session[:prefecture] = user_params[:prefecture]
    session[:city] = user_params[:city]
    session[:address] = user_params[:address]
    session[:building] = user_params[:building]
    session[:phone_number] = user_params[:phone_number]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      name_family: session[:name_family],
      name_first: session[:name_first], 
      name_family_kana: session[:name_family_kana], 
      name_first_kana: session[:name_first_kana],
      cellphone_number: session[:cellphone_number]
    )
    @address = @user.build_address(
      postal_code: user_params[:address_attributes].dig(:postal_code),
      prefecture: user_params[:address_attributes].dig(:prefecture),
      city: user_params[:address_attributes].dig(:city),
      address: user_params[:address_attributes].dig(:address),
      building: user_params[:address_attributes].dig(:building),
      phone_number: user_params[:address_attributes].dig(:phone_number)
    )
    render '/signup/step3' unless @address.valid?
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :password, 
      :cellphone_number, 
      :name_family, 
      :name_family_kana, 
      :name_first, 
      :name_first_kana, 
      address_attributes:[:id, :postal_code, :prefecture, :city, :address, :building, :phone_number]
    )
  end
end
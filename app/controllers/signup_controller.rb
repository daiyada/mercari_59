class SignupController < ApplicationController

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
    if @user.save
      session[:id] = @user.id
      redirect_to done_signup_index_path
    else
      render '/users/new'
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
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

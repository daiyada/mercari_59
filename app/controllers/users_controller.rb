class UsersController < ApplicationController
  def index
    user = User.find(1)
    @id = user.card.user_id
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "アカウントを作成しました"
    else
      render :new
    end
  end

  def new
  end

  def edit
  end

  def logout
  end

  def info
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :cellphone_number, :name_family, :name_family_kana, :name_first, :name_first_kana)
  end
end

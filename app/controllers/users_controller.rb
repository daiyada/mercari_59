class UsersController < ApplicationController
  before_action :set_navi, only: [:index ,:create, :new , :edit , :logout , :info]
  before_action :set_user, only: [:edit, :logout, :info]
  def index
    @user = User.find(current_user.id)
    @id = @user.card.user_id
  end

  def new
  end

  def edit
  end

  def logout
  end

  def info
    @address = @user.address
  end

  private
  def set_navi
    navicategory = Category.where(ancestry: nil)
    @navicategory = navicategory.pluck(:name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

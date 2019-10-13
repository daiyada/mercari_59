class UsersController < ApplicationController
  before_action :set_navi, only: [:index ,:create, :new , :edit , :logout , :info]
  def index
    user = User.find(current_user.id)
    @id = user.card.user_id
  end

  def create
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
  def set_navi
    navicategory = Category.where(ancestry: nil)
    @navicategory = navicategory.pluck(:name)
  end
end

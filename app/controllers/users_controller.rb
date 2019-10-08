class UsersController < ApplicationController
  def index
    user = User.find(1)
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

end

class Api::V1::UsersController < ApplicationController

  before_action :authorized, only: [:show]

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      render json: { obj: @user, message: 'ok' }
    else  
      render json: { message: @user.errors.full_messages }
    end
  end

  def show
    @user = User.find(params[:id])

    render json: { obj: @user, message: @obj&.errors&.full_messages }
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: { obj: @user, message: 'ok' }
    else
      render json: { message: @user&.errors&.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
# TEST
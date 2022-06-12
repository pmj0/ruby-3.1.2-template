class Api::V1::SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: { obj: @user, message: 'ok', token: token }
    else  
      render json: { message: @obj.errors&.full_messages }
    end
  end

  def destroy
    session[:user_id] = nil
    
    render json: { obj: [], message: 'ok' }
  end
end

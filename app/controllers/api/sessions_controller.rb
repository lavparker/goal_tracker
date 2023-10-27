class Api::SessionsController < ApplicationController

  def show
    if current_user
      render json: {user: current_user}
    else
      render json: {user: nil}
    end
  end

  def create

    credential = params[:credential]
    password = params[:password]

    @user = User.find_by_credentials(credential, password)

    if @user
      login!(@user)
      # session[:user_id] = @user.id
      render json: {user: @user}
    else
      render json: {errors: ['The provided credentials were invalid.']}, status: :unauthorized
    end

  end

  def destroy

      logout!
      render json: {message: 'success'}
  end
end

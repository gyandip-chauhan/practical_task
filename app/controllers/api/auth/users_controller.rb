class Api::Auth::UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:signup, :signin]

  def signup
    user = User.new(signup_params)
    if user.save
      render json: {data: user, message: "Sign up Successfully!"}, status: 200
    else
      render json: {errors: user.errors.full_messages}, status: 400
    end
  end

  def signin
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user.present? 
      if user.valid_password?(params[:user][:password])
        render json: {data: {user_id: user.id, email: user.email, token: user.generate_jwt_token}, message: "Success"}, status: 200
      else
        render json: {error: "Invalid Credentials" }, status: 401
      end
    else
      render json: {error: "User not Found" }, status: 404
    end
  end
  
  private

  def signup_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

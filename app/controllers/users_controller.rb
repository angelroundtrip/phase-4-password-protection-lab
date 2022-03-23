class UsersController < ApplicationController

  

  # * POST /signup  request 
  # create a new user; save their hashed password in the database; save the user's ID in the session hash; and return the user object in the JSON response.
  def signup
    user = User.create(user_params)
    if user&.authenticate(params[:password])
      user.save
      session[:user_id].save
      render json: user, status: :created
    else
      render json: {error: "Unable to create user"}, status: 422
    end
  end

  # * GET /me
  # responds to a GET /me request. If the user is authenticated, return the user object in the JSON response.
  def show
    user = User.find_by(id:params[:id])
    if user&.authenticate(params[:password])
      render json: user, status: :ok
    else
      render json: {error: "Unauthorized"}, status: 401
    end
  end


  private

  def user_params
    params.permit(:user, :password, :password_confirmation)
  end

  

end

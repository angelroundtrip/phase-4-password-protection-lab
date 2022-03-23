class SessionsController < ApplicationController

  skip_before_action :authorize, only: [:login]

  # * POST /login
  # with valid username and password, returns the logged in user, sets the user ID in the session
  # with invalid password, returns a 401 unauthorized response, does not set the user ID in the session
  # with invalid username, returns a 401 unauthorized response, does not set the user ID in the session
  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {error: "Invalid username or password"}, status: :unauthorized
    end
  end

  # * DELETE /logout
  # a destroy action for logging out that responds to a DELETE /logout request.
  def logout
    session.delete :user_id
    head :no_content
  end


  private

  def user_params
    params.permit(:username, :password)
  end

end

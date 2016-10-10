class UsersController < ApplicationController

  #/users/authenticate
  def authenticate
    if authenticate_token
      render json: "Authorized", status: :ok if @current_user
    else
      render_unauthorized
    end
  end

  # POST /users
  def create
    user = User.new(users_params)
    if user.save
      render :json => user.as_json(only: [:name,:email,:api_token])
    else
      render :json => {:error =>  user.errors.full_messages}
    end
  end

  #/users/regenerate_token
  def regenerate_token
    user = User.find_by_email(users_params[:email])
    if user && user.authenticate(params[:password])
      user.update_attribute("api_token", user.generate_auth_token )
      render :json => user.as_json(only: [:name,:email,:api_token])
    else
      render :json => {:error =>  "Invalid User"}
    end
  end

  private

  def users_params
    params.permit(:email,:password,:name)
  end

end

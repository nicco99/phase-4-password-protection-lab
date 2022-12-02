class UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
def create
  user = User.create(user_params)
  if user.valid?
    session[:user_id] = user.id
    render json: user, status: :created
  else
    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  end
end

  def show
    user = User.find(session[:user_id])
      render json: user
  end

  private

def record_invalid invalid
  render json: { errors: invalid.record.errors }, status: :unprocessable_entity
end

def record_not_found
render json: { errors: "Unauthorized access"}, status: :unauthorized
end

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end


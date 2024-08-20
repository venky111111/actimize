class UsersController < ApplicationController
	before_action :authorize_request, except: [:create, :verify_otp]
  before_action :find_user, except: %i[create index]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.create(user_params)
    if @user.save
       email_otp = rand(1000..9999)
      UserMailer.welcome_email(@user, email_otp).deliver_now
      render json: { user: @user , otp: email_otp}, status: :created
    else
      render json: { errors: @user.errors.full_messages },status: :unprocessable_entity
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },status: :unprocessable_entity
    end
  end
  def destroy
    @user.destroy
  end

  def verify_otp
    binding.pry
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:name, :phone_number, :email, :password, :password_confirmation)
  end
end

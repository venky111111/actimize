class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    case params[:type]
    when "email_account"
      email_account_login
    when "social_account"
      social_account_login
    else
      render json: { error: 'Invalid login type' }, status: :bad_request
    end
  end

  private

  def email_account_login
    @user = User.find_by(email: params[:email]) if params[:email].present?
    if @user&.authenticate(params[:password])
      render_token_response(@user)
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def social_account_login
    uid = params[:uid]
    provider = params[:provider]
    email = params[:email]

    @user = SocialAccount.find_by(email: email)

    if @user
      generate_token_response(@user)
    else
      user_params = login_params.except(:type).merge(password: generate_secure_password)
      @user = SocialAccount.new(user_params)


      if @user.save
        generate_token_response(@user)
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def render_token_response(user)
    token = JsonWebToken.encode(user_id: user.id)
    time = Time.now + 24.hours.to_i
     
      

    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: user}, status: :ok
  end

  def generate_token_response(user)
    if user
      render_token_response(user)
    else
      render json: { message: "Your account has not been verified/activated." }, status: :ok
    end
  end

  def login_params
    params.permit(:email, :password, :provider,:uid )
  end

  def generate_secure_password
    SecureRandom.hex(4)  
  end
end

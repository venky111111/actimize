class UsersController < ApplicationController
	before_action :authorize_request, except: [:create, :verify_otp, :user_role, :forgot_password, :reset_password]
  before_action :find_user, except: %i[create index verify_otp user_role forgot_password reset_password]

  def index
    @users = User.all
    render json: @users, status: :ok
  end


  def show
    render json: @user, status: :ok
  end

def create
  type = params[:type]
  case type
  when "email_account"
    @user = User.new(user_params)
    if @user.save
      otp = rand(1000..9999)
      email_otp = EmailOtp.new(
        otp_expiry: Time.now + 1.minutes,
        otp_number: otp,
        user_id: @user.id
      )

      if email_otp.save
        # UserMailer.welcome_email(@user, email_otp).deliver_now
         render json: { messages: "Email OTP sent successfully", user: @user, otp: otp }, status: :ok
      else
   
        render json: { errors: "Failed to save OTP" }, status: :unprocessable_entity
      end
    else

      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      
    end
    when "social_account"
  
    @user = SocialAccount.new(user_params)
   
    if @user.save
      otp = rand(1000..9999)
      sms_otp = SmsOtp.new(
        otp_expiry: Time.now + 1.minutes,
        otp_number: otp,
        user_id: @user.id
      )
      
      if sms_otp.save
       
        render json: { success: true, messages: 'OTP sent successfully', otp: otp, user: @user }
      else
        render json: { errors: "Failed to save OTP" }, status: :unprocessable_entity
      end
    else
       render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      
    end    
  else
    render json: { errors: "Invalid sign up type" }, status: :unprocessable_entity
  end
end

  # def create
  #   @user = User.create(user_params)
  #   if @user.save
  #      email_otp = rand(1000..9999)
  #     UserMailer.welcome_email(@user, email_otp).deliver_now
  #     render json: { user: @user , otp: email_otp}, status: :created
  #   else
  #     render json: { errors: @user.errors.full_messages },status: :unprocessable_entity
  #   end
  # end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },status: :unprocessable_entity
    end
  end
  def destroy
    @user.destroy
  end

  def forgot_password
   
    if params[:email].present?
      user = User.find_by(email: params[:email])

    if user && user.email_verified?
      otp = rand(1000..9999)
      email_otp = EmailOtp.find_by(user_id: user.id)
      otp_send = email_otp.update(otp_expiry: Time.now + 10.minutes, otp_number: otp, user_id: user.id)

      if otp_send
        render json: { messages: "OTP sent successfully to email.", success: true, otp: otp, user: user }, status: :ok
      else
        render json: { errors: otp.errors.full_messages, success: false }, status: :unprocessable_entity
      end
    else
      render json: { errors: "Email not verified or user not found.", success: false }, status: :unprocessable_entity
    end
    elsif params[:phone_number].present?
    user = User.find_by(phone_number: params[:phone_number])

    if user && user.mobile_verified?
      otp = rand(1000..9999)
      sms_otp = SmsOtp.new(
        otp_expiry: Time.now + 1.minutes,
        otp_number: otp,
        user_id: user.id
      )

      if sms_otp.save
     
        return render json: { success: true, messages: 'OTP sent successfully to phone number.', otp: otp, user: user }, status: :ok
      else
        return render json: { errors: sms_otp.errors.full_messages, success: false }, status: :unprocessable_entity
      end
    else
      return render json: { errors: "Phone number not verified or user not found.", success: false }, status: :unprocessable_entity
    end
    else
      return render json: { errors: "Email or phone number is missing.", success: false }, status: :unprocessable_entity
    end
  end

def verify_otp
  if params[:user_id].present?
    user = User.find(params[:user_id])
    # binding.pry
    if params[:email].present? && params[:email] == user.email
        otp = EmailOtp.where('user_id = ?', user.id).last

     elsif params[:phone_number].present? && params[:phone_number] == user.phone_number.to_s
      otp = SmsOtp.where('user_id = ? and otp_expiry >= ?', user.id, Time.current).last
    end
    if otp 
      if otp.otp_number == params[:otp]
        user.email_verified = true if params[:email].present?
        user.mobile_verified = true if params[:phone_number].present?
        if user.save
          render json: { messages: "Your OTP has been verified successfully.", user: user }, status: :ok
        else
          render json: { errors: user.errors.full_messages, message: "test" }, status: :unprocessable_entity
        end
      else
        render json: { messages: "Invalid OTP. Please enter the correct OTP." }, status: :unprocessable_entity
      end
    else 
      render json: { messages: "No record found or otp is expired. Please generate a new OTP." }, status: :unprocessable_entity
    end
  else
    render json: { messages: "Please provide a user ID." }, status: :unprocessable_entity
  end
end
def user_role
  if params[:user_id].present?
    user = User.find(params[:user_id])
    if user 
      if user.update(role: params[:role])
          render json: { messages: "Role added successfully.", user: user }, status: :ok
      else
            render json: { messages: "There is an error Please try again later", error: user.errors.full_messages }, status: :unprocessable_entity
      end

    end
  end
end

def reset_password
  user = User.find(params[:user_id]);
  if user
    if user.update(password: params[:password], password_confirmation: params[:password_confirmation])
         render json: { messages: 'Password updates successfully.', user: user}, status: :ok
    else
      render json: { messages: 'Password updation failed'}, status: :ok
    end
  end
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

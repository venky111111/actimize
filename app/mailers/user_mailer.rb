class UserMailer < ApplicationMailer

  def welcome_email(user, email_otp)
    @user = user
    @otp = email_otp
    mail(to: @user.email, subject: 'Email Verification')
  end

end

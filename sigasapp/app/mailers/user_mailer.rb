class UserMailer < ApplicationMailer
  default from: 'no-reply@faccat.br'
 
  def welcome_email(user, pwd)
    @user = user
    @pwd = pwd
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Bem-vindo ao FACCAT SiGAs')
  end
  
  def reser_pwd_email(user, pwd)
    @user = user
    @pwd = pwd
    mail(to: @user.email, subject: 'Sua senha foi alterada | FACCAT SiGAs')
  end
end
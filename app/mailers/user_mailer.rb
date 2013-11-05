class UserMailer < ActionMailer::Base
  default from: "kumaks09@yandex.ru"
  def welcome_email(user)
    @user = user
    @url  = 'http://ya.ru'
    mail(to: user.email, subject: 'Welcome')
  end
end

class UserMailer < ActionMailer::Base
  default from: "announcer@inter-activity.ru"

#  def request_email(user, game, dt)   # Нотификатор Админу про новый запрос
  def newreg_email(user)   # Нотификатор Админу про новый запрос
    @user = user
    mail(to: "pijammer@gmail.com", subject: "New User on EvenLift") 
  end

end

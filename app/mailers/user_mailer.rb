class UserMailer < ActionMailer::Base
  default from: ENV['MAILER_DEFAULT_FROM']

  def questionary_submitted(user)
    @user = user
    @url  = root_url
    @app_name  = ENV['APP_NAME']
    @fondeso_contact  = ENV['MAILER_ADDRESS_FONDESO']
    mail(to: @user.email, subject: 'Hemos recibido tu cuestionario')
  end
end

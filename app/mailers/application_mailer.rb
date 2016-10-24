class ApplicationMailer < ActionMailer::Base
  default from: "reset@#{ENV["DOMAIN"]}.com"
  layout "mailer"
end

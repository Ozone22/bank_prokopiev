class ApplicationMailer < ActionMailer::Base
  default from: "no_respond@trustbank.com"
  layout "mailer"
end

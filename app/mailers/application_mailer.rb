class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "dougmorgen.com <no-reply@dougmorgen.com>")
  layout "mailer"
end

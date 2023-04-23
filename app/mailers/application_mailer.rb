# frozen_string_literal: true

# Permite o envio de emails da sua aplicação
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end

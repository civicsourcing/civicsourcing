class MiscMailer < ActionMailer::Base
  include ActionController::Helpers
  helper MarkdownHelper

  layout "mailer"
  default from: "CivicSourcing <community@civicsourcing.com>"

  def deliver_petition(petition)
    @petition = petition
    mail(subject: petition.title, to: petition.deliver_to)
  end
end

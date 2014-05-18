class FundMailer < ActionMailer::Base
  include ActionController::Helpers
  helper MarkdownHelper

  layout "mailer"
  default from: "CivicSourcing <community@civicsourcing.com>"

  def funded(fund)
    @fund = fund
    @user = fund.user
    mail(subject: "'#{ @fund.title }' funded!", to: @user.email)
  end

  def underfunded_donor(fund_donation)
    @fund = fund_donation.fund
    @user = fund_donation.user
    mail(subject: "'#{ @fund.title }' underfunded", to: @user.email)
  end

  def underfunded_manager(fund)
    @fund = fund
    @user = fund.user
    mail(subject: "'#{ @fund.title }' underfunded", to: @user.email)
  end

  def paid(fund_donation)
    @fund = fund_donation.fund
    @user = fund_donation.user
    mail(subject: "'#{ @fund.title }' succeeded!", to: @email)
  end

  def payment_failed(fund_donation)
    @fund = fund_donation.fund
    @user = fund_donation.user
    mail(subject: "Payment failed for '#{ @fund.title }'", to: @user.email)
  end
end

class OrderFulfiller

  attr_accessor :donation, :fund, :donor, :merchant, :order
  def initialize(donation)
    @donation = donation
    @fund = donation.fund
    @donor = donation.user
    @merchant = donation.fund.event.creator.customer
    @order = @merchant.create_order
  end

  def pay
    create_debit
    create_credit
  end

  private
  def create_debit
    debit = order.debit_from(
      source: donor.customer.source,
      amount: donation.amount * 100,
      appears_on_statement_as: "Donation to CivicSourcing fund #{ fund.title }",
      description: "Donation to fund #{ fund.title } from #{ donor.username }"
    )
    notify_user_about_order(debit)
  end

  def create_credit
    order.credit_to(
      destination: merchant.destination,
      amount: (donation.amount * 93.1) - 80,
      appears_on_statement_as: "Donation to fund #{ fund.title } from #{ donor.username }",
      description: "Donation to fund #{ fund.title } from #{ donor.username }"
    )
  end

  def notify_user_about_order(debit)
    if debit.status == "succeeded"
      donation.update_column(:paid, true)
      FundMailer.paid(donation).deliver
    else
      FundMailer.payment_failed(donation).deliver
    end
  end
end

class TransactionMailer < ApplicationMailer
  def confirmation(purchase, transaction)
    @purchase = purchase
    @transaction = transaction

    mail to: @transaction.sender.email, from: ENV['admin_email'],
         subject: "Thank you for supporting #{@transaction.recipient.name}!"
  end
end

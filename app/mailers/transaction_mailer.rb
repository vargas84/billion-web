class TransactionMailer < ApplicationMailer
  def confirmation(transaction)
    @transaction = transaction

    mail to: @transaction.sender.email, from: ENV['admin_email'],
         subject: "Thank you for supporting #{@transaction.recipient.name}!"
  end
end

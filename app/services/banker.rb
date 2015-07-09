class Banker
  class ClientPaymentError < StandardError; end

  class PaymentError < StandardError; end
  
  def self.take_money(token, amount)
    begin
      result = Braintree::Transaction.sale(
        :amount => amount,
        :payment_method_nonce => token
      )

      if !result.success?
        # client error
        raise ClientPaymentError.new(result.message)
      end

    rescue
      # braintree service failure
      # TODO log to new relic
      raise PaymentError()
    end
end

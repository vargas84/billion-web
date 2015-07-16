class Payment

  class PaymentServiceError < StandardError; end

  attr_reader :errors

  def initialize(token, amount)
    @token = token
    @amount = amount
  end

  def pay
      begin
        result = Braintree::Transaction.sale(
          :payment_method_nonce => @token,
          :amount => @amount
        )

        if result.success?
          true
        else
          # validation error, e.g. rejected etc
          @errors = result.errors.map { |error| error.message }

          puts @errors.inspect
          false
        end
      rescue Braintree::AuthenticationError,
        Braintree::AuthorizationError,
        Braintree::ConfigurationError,
        Braintree::DownForMaintenanceError,
        Braintree::ForgedQueryString,
        Braintree::InvalidChallenge,
        Braintree::InvalidSignature,
        Braintree::NotFoundError,
        Braintree::ServerError,
        Braintree::SSLCertificateError,
        Braintree::UnexpectedError,
        Braintree::UpgradeRequiredError => e

        # likely a braintree service failure
        # TODO log to new relic
        raise PaymentServiceError.new(e.message)
      end
  end

end
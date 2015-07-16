class Payment
  class PaymentServiceError < StandardError; end

  BRAINTREE_ERRORS = [Braintree::AuthenticationError,
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
                      Braintree::UpgradeRequiredError]

  attr_reader :errors

  def initialize(token, amount)
    @token = token
    @amount = amount
  end

  def pay
    result = Braintree::Transaction.sale(payment_method_nonce: @token, amount: @amount)

    if result.success?
      true
    else
      # validation error, e.g. rejected etc
      @errors = result.errors.map(&:message)
      false
    end
  rescue *BRAINTREE_ERRORS => e
    # likely a braintree service failure
    # TODO: log to new relic
    raise PaymentServiceError, e.message
  end
end

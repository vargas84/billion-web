
class Payment
  class RecordInvalid < StandardError
    attr_reader :record

    def initialize(record, msg)
      super msg
      @record = record
    end
  end

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

    validate_amount_type
  end

  def pay
    transaction_result = create_transaction

    return true if transaction_result.success?

    # validation error, e.g. rejected etc
    @errors = transaction_result.errors.map(&:message)
    if @errors.size == 0
      @errors << 'Sorry, we are having trouble processing your payment.'
    end

    false
  rescue *BRAINTREE_ERRORS => e
    # likely a braintree service failure
    # TODO: log to new relic
    raise PaymentServiceError, e.message
  end

  def pay!
    return true if pay && errors.nil?
    fail RecordInvalid.new(self, 'payment is invalid')
  end

  private

  def create_transaction
    Braintree::Transaction.sale(
      payment_method_nonce: @token,
      amount: @amount,
      options: {
        submit_for_settlement: true
      }
    )
  end

  def validate_amount_type
    return if @amount.is_a?(String) || @amount.is_a?(BigDecimal)
    fail TypeError, 'Amount must be a String or BigDecimal'
  end
end

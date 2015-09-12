require 'rails_helper'

describe Payment do
  describe '.pay!' do
    context 'nonce is valid' do
      subject(:make_payment) { Payment.new('fake-valid-nonce', '2').pay! }

      it 'returns true' do
        expect(make_payment).to eql(true)
      end
    end

    context 'client token was already consumed' do
      subject(:make_payment) { Payment.new('fake-valid-nonce', '2').pay! }

      before { FakeBraintree.decline_all_cards! }

      it 'throws a Payment::RecordInvalid error' do
        expect { make_payment }.to raise_error(Payment::RecordInvalid)
      end

      after { FakeBraintree.clear! }
    end
  end

  describe '.pay' do
    it 'returns throws error if amount is not string or big decimal' do
      expect { Payment.new('fake-valid-nonce', 2.33) }.to raise_error(TypeError)
    end

    it 'returns true if nonce is valid' do
      expect(Payment.new('fake-valid-nonce', '2.33').pay).to eql(true)
    end

    it 'returns false if client token was already consumed' do
      FakeBraintree.decline_all_cards!
      expect(Payment.new('fake-consumed-nonce', '2').pay).to eql(false)
      FakeBraintree.clear!
    end

    it 'sets the errors messages' do
      FakeBraintree.decline_all_cards!
      payment = Payment.new('fake-consumed-nonce', '2')
      payment.pay
      expect(payment.errors).not_to be_empty
      FakeBraintree.clear!
    end

    # these exceptions take one optional argument
    [
      Braintree::AuthenticationError,
      Braintree::AuthorizationError,
      Braintree::DownForMaintenanceError,
      Braintree::ForgedQueryString,
      Braintree::InvalidChallenge,
      Braintree::InvalidSignature,
      Braintree::NotFoundError,
      Braintree::ServerError,
      Braintree::SSLCertificateError,
      Braintree::UnexpectedError,
      Braintree::UpgradeRequiredError
    ].each do |braintree_error|
      it "raises PaymentServiceError when Braintree encounters a #{braintree_error.name}" do
        nonce = 'fake-valid-nonce'
        amount = '2'
        expect(Braintree::Transaction).to receive(:sale)
          .with(
            payment_method_nonce: nonce,
            amount: amount,
            options: { submit_for_settlement: true }
          ).and_raise(braintree_error)
        expect { Payment.new(nonce, amount).pay }.to raise_error(Payment::PaymentServiceError)
      end
    end

    # separate test from loop because ConfigurationError takes two arguments
    it 'raises PaymentServiceError when Braintree encounter a Braintree::ConfigurationError' do
      nonce = 'fake-valid-nonce'
      amount = '2'
      expect(Braintree::Transaction).to receive(:sale)
        .with(
          payment_method_nonce: nonce,
          amount: amount,
          options: { submit_for_settlement: true }
        ).and_raise(Braintree::ConfigurationError.new('setting', 'message'))
      expect { Payment.new(nonce, amount).pay }.to raise_error(Payment::PaymentServiceError)
    end
  end
end

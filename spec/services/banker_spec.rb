require 'spec_helper'

describe Banker do
	describe '.take_money' do
    it 'raises ClientPaymentError if client token was already consumed' do
      expect { Banker.take_money('fake-consumed-nonce', 2) }.to raise(Banker::ClientPaymentError)
    end
  end
end

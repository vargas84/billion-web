require 'fake_braintree'
FakeBraintree.activate!

RSpec.configure do |c|
  c.before do
    FakeBraintree.clear!
  end
end

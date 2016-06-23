require 'spec_helper'

describe Primata::Twilio do
  let(:account_sid)  { 'AC5ef8732a3c49700934481addd5ce1659' }
  let(:auth_token)   { '2ecaf0108548e09a74387cbb28456aa2' }
  let(:phone_number) { '+6281234567890' }
  let(:twilio)       { described_class.new(account_sid, auth_token, phone_number) }

  context 'accessor' do
    it { expect(twilio.client).to be_an_instance_of(Twilio::REST::Client) }
    it { expect(twilio.phone_number).to eq(phone_number) }
  end

  describe '#send_sms' do
    before do
      allow(twilio).to receive(:send_sms).and_return('OK')
    end

    it { expect(twilio.send_sms('+62271234567', 'hello')).to eq('OK') }
  end
end

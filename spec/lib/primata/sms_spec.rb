require 'spec_helper'

describe Primata::SMS do
  describe ".normalized_number" do
    context "valid number" do
      [
        " 62 812 345 678 90",
        "+62 812 345 678 90",
        "+62-812-345-678-90",
        "+6281234567890",
        "6281234567890",
        "081234567890",
        "0812-345-678-90",
        "0812_345_678_90",
        "0812.345.678.90",
      ].each do |number|
        it { expect(described_class.normalized_number(number)).to eq("+6281234567890") }
      end

      it { expect(described_class.normalized_number("0271234567")).to eq("+62271234567") }
      it { expect(described_class.normalized_number("(0271) 234567")).to eq("+62271234567") }
      # it { expect(described_class.normalized_number("0271234567891234567890123456789")).to eq("+62271234567") }
    end

    context "bad number" do
      it { expect(described_class.normalized_number("this-is-my-number")).to be_nil }
      # it { expect(described_class.normalized_number("0812")).to be_nil }
    end
  end
end

describe Primata::Twilio do
  let(:account_sid)  { "AC5ef8732a3c49700934481addd5ce1659" }
  let(:auth_token)   { "2ecaf0108548e09a74387cbb28456aa2" }
  let(:phone_number) { "+6281234567890" }
  let(:twilio)       { described_class.new(account_sid, auth_token, phone_number) }

  context "accessor" do
    it { expect(twilio.client).to be_an_instance_of(Twilio::REST::Client) }
    it { expect(twilio.phone_number).to eq(phone_number) }
  end

  describe "#send_sms" do
    before do
      allow(twilio).to receive(:send_sms).and_return("OK")
    end

    it { expect(twilio.send_sms("+62271234567", "hello")).to eq("OK") }
  end
end


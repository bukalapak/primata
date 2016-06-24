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
    let(:twilio_url)    { 'https://AC5ef8732a3c49700934481addd5ce1659:2ecaf0108548e09a74387cbb28456aa2@api.twilio.com/2010-04-01/Accounts/AC5ef8732a3c49700934481addd5ce1659/Messages.json' }
    let(:twilio_params)   do
      { 'Body' => 'hello', 'From' => '+6281234567890', 'To' => '+62271234567' }
    end

    let(:twilio_response) do
      {
        'sid' => 'MMc781610ec0b3400c9e0cab8e757da937',
        'date_created' => 'Mon, 19 Oct 2015 07 =>07 =>03 +0000',
        'date_updated' => 'Mon, 19 Oct 2015 07 =>07 =>03 +0000',
        'date_sent' => nil,
        'account_sid' => 'AC5ef8732a3c49700934481addd5ce1659',
        'to' => '+62271234567',
        'from' => '+6281234567890',
        'body' => 'hello',
        'status' => 'queued',
        'num_segments' => '1',
        'num_media' => '1',
        'direction' => 'outbound-api',
        'api_version' => '2010-04-01',
        'price' => nil,
        'price_unit' => 'USD',
        'error_code' => nil,
        'error_message' => nil,
        'uri' => '/2010-04-01/Accounts/AC5ef8732a3c49700934481addd5ce1659/Messages/MMc781610ec0b3400c9e0cab8e757da937.json',
        'subresource_uris' => {
          'media' => '/2010-04-01/Accounts/AC5ef8732a3c49700934481addd5ce1659/Messages/MMc781610ec0b3400c9e0cab8e757da937/Media.json'
        }
      }.to_json
    end

    before do
      stub_request(:post, twilio_url).with(body: twilio_params).to_return(status: 200, body: twilio_response)
    end

    subject { twilio.send_sms('+62271234567', 'hello') }

    it { expect(subject.status).to eq('queued') }
    it { expect(subject.to).to eq('+62271234567') }
    it { expect(subject.from).to eq('+6281234567890') }
    it { expect(subject.body).to eq('hello') }
    it { expect(subject.direction).to eq('outbound-api') }
    it { expect(subject.account_sid).to eq('AC5ef8732a3c49700934481addd5ce1659') }
    it { expect(subject.api_version).to eq('2010-04-01') }
    it { expect(subject.error_code).to eq(nil) }
  end
end

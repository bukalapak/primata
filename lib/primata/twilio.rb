require 'twilio-ruby'

module Primata
  class Twilio
    attr_reader :client
    attr_reader :phone_number

    def initialize(account_sid, auth_token, phone_number)
      @client = ::Twilio::REST::Client.new(account_sid, auth_token)
      @phone_number = phone_number
    end

    def send_sms(number, msg)
      client.account.messages.create(from: @phone_number, to: number, body: msg)
    end
  end
end

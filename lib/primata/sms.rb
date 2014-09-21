require 'twilio-ruby'
require 'phonelib'

Phonelib.default_country = 'ID'

module Primata
  class SMS
    def self.normalized_number(number)
      number = Phonelib.parse(number.to_s)
      return if number.invalid?

      number.international.gsub(/[^+0-9]+/, '')
    end
  end

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

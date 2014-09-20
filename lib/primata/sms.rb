require 'twilio-ruby'

module Primata
  class SMS
    def self.normalized_number(number)
      number = number.to_s
      numbers = number.split(/\/|,|\\|[A-Za-z]/).map(&:strip).map{|n| n.gsub(/\D/, "")}
      number = numbers.find{|n| n =~ /^08/ } || numbers.max{|n| n.length } || numbers.first || return
      number = number[/\+?([\d -_\.]+)/] || return
      number.strip!
      number = number.gsub(/ /, "")
      number = number.sub(/^0/, "+62")
      number = number.sub(/^62/, "+62")
      number = "+62#{number}" unless number =~ /^\+62/
      number
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

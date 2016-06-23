require 'phonelib'

module Primata
  class SMS
    def self.normalized_number(number)
      number = Phonelib.parse(number.to_s, 'ID')
      return if number.invalid?

      number.international.gsub(/[^+0-9]+/, '')
    end
  end
end

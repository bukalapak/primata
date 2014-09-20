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
end

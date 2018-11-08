require 'rubygems'
require 'nokogiri'
require 'open-uri'

class StartScrap


 def initialize
     @document = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
     @crypto = CryptoCurrency.new
 end

 def perform
     rows = @document.xpath('//*[@id="currencies-all"]/tbody').css('tr')
     rows.each do |row|
         price = row.css('td[5]').text.strip[1..-1]
         @crypto = CryptoCurrency.create!(name: row.css('td[2]').text, price: price.strip[1..-1].to_f)

   end
 end

 def update
     id = 0
     rows = @document.xpath('//*[@id="currencies-all"]/tbody').css('tr')
     rows.each do |row|
         id += 1
         price = row.css('td[5]').text.strip[1..-1]
         @crypto = CryptoCurrency.find(id)
         @crypto.update(name: row.css('td[2]').text, price: price.strip[1..-1].to_f)
     end
 end

end

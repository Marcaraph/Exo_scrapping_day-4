require 'nokogiri'
require 'open-uri'
require 'rspec'

def scrap_names(url)
    page = Nokogiri::HTML(URI.open(url))
    crypto_list = page.xpath('//table/tbody/tr[*]/td[3]/div')
    crypto_list.map { |name| name.text }
end

def scrap_prices(url)
    page = Nokogiri::HTML(URI.open(url))
    crypto_price = page.xpath('//table/tbody/tr[*]/td[5]/div')
    crypto_price.map { |price| price.text }
end

def create_crypto_data(url)
    names = scrap_names(url)
    prices = scrap_prices(url)
    Hash[names.zip(prices)]
end

url = 'https://coinmarketcap.com/all/views/all/'
result = create_crypto_data(url)
puts result
require 'openssl'
require 'nokogiri'
require 'open-uri'
require 'rspec'


def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text.strip
    email unless email.empty?
end

def get_townhall_urls(url)
    page = Nokogiri::HTML(URI.open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
    townhall_urls = {}
    links = page.xpath('//a[@class="lientxt"]')                                                                                 #extraire les liens <a> qui ont l'attribut class=lientxt
  
    links.each do |link|
      townhall_url = link['href'].start_with?('http') ? link['href'] : "https://www.annuaire-des-mairies.com#{link['href']}"    # vérifie si le href de chaque lien commence par http : si oui, utilise le href tel quel ; si non, construit l'url en ajoutant le préfixe annuaire-des-mairies.com au href
      townhall_url.sub!('https://www.annuaire-des-mairies.com./', 'https://www.annuaire-des-mairies.com/')                      # Supprimer le point en trop dans l'URL si présent
      townhall_urls[link.text] = townhall_url                                                                                   # Link nom de ville et url
    end 
    townhall_urls
end

val_doise_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"
townhall_urls = get_townhall_urls(val_doise_url)

townhall_results_array = []

townhall_urls.each do |ville, url|
  email = get_townhall_email(url)
  townhall_results_array << { ville: ville, email: email } if email
end

townhall_results_array.each do |result|
  puts "#{result[:ville]} => #{result[:email]}"
end
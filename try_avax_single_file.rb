require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'
  
url =  "http://www.animephile.com/hentai/gakuen-seikatsu.html"
page = Nokogiri::HTML(open(  url     ))  
results = page.css(".selectpage option")
total_page = results.count 

images = [] 
(1.upto total_page).each do |page_number|
 
    page_url = url + "?ch=Volume+01"  +  "&page=#{page_number}"
    page = Nokogiri::HTML(open(  page_url     ))  
    result = page.css("#mainimage")
    images <<  result.map {|x| x['src'] } .first
end

puts images
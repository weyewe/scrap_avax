require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_URL = 'http://avaxhome.ws'
PAGE_COUNT = 20


url = BASE_URL

# 1. get all posts > put it in File.txt 
# 2. get next page.. if there is no next_page, finish. 

page = Nokogiri::HTML(open(  url     ))  

results = page.css("div.news h1 a")

file_content = ""
counter = 1 
results.each do |result|
  title = result.text
  link  = "#{BASE_URL}#{result.attributes['href'].value}"
  file_content  << "#{counter}.  #{title}\n" 
  file_content << "#{link}\n\n"
  
  counter += 1 
end

File.open('avax_result.txt', 'w') {|f| f.write(file_content) }
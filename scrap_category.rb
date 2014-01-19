require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'cgi'

BASE_URL = 'http://avaxhome.ws' # http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
PAGE_COUNT = 20

FILENAME = 'avax_category.txt'

# http://avaxhome.ws/ebooks/economics_finances


# http://avaxhome.ws/video/genre/crime/Boomerang_Fox_Film_Noir.html



material = 'video'
category = ''
url = "#{BASE_URL}/#{material}/#{category}"


file_content = ""

counter = 1

file_content << "Material: #{material} || Category: #{category}\n\n"

(1..PAGE_COUNT).each do |page_count|
  page = Nokogiri::HTML(open(  url     ))  

  results = page.css("div.news h1 a")
  results.each do |result|
    title = result.text
    link  = "#{BASE_URL}#{result.attributes['href'].value}"
    file_content  << "#{counter}.  #{title}\n" 
    file_content << "#{link}\n\n"

    counter += 1 
  end
  
  next_page = page.css("a.next_page").first 
  break if next_page.nil?
  url = "#{BASE_URL}#{next_page.attributes['href'].value}"
end

File.open(FILENAME , 'w') {|f| f.write(file_content) }
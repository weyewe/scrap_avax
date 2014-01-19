require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'

BASE_URL = 'http://avaxsearch.com' # http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
PAGE_COUNT = 20

FILENAME = 'avax_search.txt'

# http://avaxsearch.com/avaxhome_search?q=sex&commit=Go

search_value = "to sell"
search_keyword = CGI.escape( search_value )



url = "#{BASE_URL}/avaxhome_search?q=#{search_keyword}&commit=Go"

file_content = ""
counter = 1

file_content << "Search Keyword: '#{search_value}'\n\n"

(1..PAGE_COUNT).each do |page_count|
  page = Nokogiri::HTML(open(  url     ))  

  results = page.css("div.item h3 a")
  results.each do |result|
    title = result.text
    link  = "#{result.attributes['href'].value}"
    file_content  << "#{counter}.  #{title}\n" 
    file_content << "#{link}\n\n"

    counter += 1 
  end
  
  next_page = page.css("a.next_page").first 
  break if next_page.nil?
  url = "#{BASE_URL}#{next_page.attributes['href'].value}" 
end

File.open(FILENAME , 'w') {|f| f.write(file_content) }
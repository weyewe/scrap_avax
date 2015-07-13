require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'

BASE_URL = 'http://avxsearch.se' # http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
PAGE_COUNT = 20

FILENAME = 'avax_search.txt'

# http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
# "marakana"
search_value =  "javascript"
search_keyword = CGI.escape( search_value )



url = "#{BASE_URL}/search?q=#{search_keyword}&commit=Search"

file_content = ""
counter = 1

file_content << "Search Keyword: '#{search_value}'\n\n"

(1..PAGE_COUNT).each do |page_count|
  puts "page: #{page_count}"
  page = Nokogiri::HTML(open(  url     ))  

  results = page.css("div.article a.title-link")
  results.each do |result|
    title = result.text
    link  = "#{result.attributes['href'].value}"
    file_content  << "#{counter}.  #{title}\n" 
    file_content << "#{link}\n\n"

    counter += 1 
  end
  
  next_page = page.css("div.pagination a[rel=next]").first 
  break if next_page.nil?
  url = "#{BASE_URL}#{next_page.attributes['href'].value}" 
end

File.open(FILENAME , 'w') {|f| f.write(file_content) }
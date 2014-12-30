require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'

# http://learningdl.com/page/2/?s=udemy

BASE_URL = 'http://learningdl.com' # http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
PAGE_COUNT = 20

FILENAME = 'learning_dl_search.txt'

# http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
# "marakana"
search_value = "udemy"
search_keyword = CGI.escape( search_value )



# http://learningdl.com/?s=udemy


url = "#{BASE_URL}/?s=#{search_keyword}"

file_content = ""
counter = 1

file_content << "Search Keyword: '#{search_value}'\n\n"

(1..PAGE_COUNT).each do |page_count|
  page = Nokogiri::HTML(open(  url     ))  

  results = page.css("h2.entry-title a")
  results.each do |result|
    title = result.text
    link  = "#{result.attributes['href'].value}"
    file_content  << "#{counter}.  #{title}\n" 
    file_content << "#{link}\n\n"

    counter += 1 
  end
  
  next_page = page.css("div.pagination-next a").first 
  break if next_page.nil?
  url = "#{next_page.attributes['href'].value}" 
end

File.open(FILENAME , 'w') {|f| f.write(file_content) }
require 'rubygems'
require 'nokogiri'
require 'open-uri'

require 'cgi'

BASE_URL = 'http://avaxhome.ws' # http://avaxsearch.com/avaxhome_search?q=sex&commit=Go
PAGE_COUNT = 20

FILENAME = 'avax_user.txt'

# http://avaxhome.ws/ebooks/economics_finances


user = 'tukotikko' 
url = "#{BASE_URL}/blogs/#{user}"


file_content = ""

counter = 1

file_content << "Blog: #{user} \n\n"

(1..2).each do |page_count|
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
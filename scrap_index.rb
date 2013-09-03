require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_URL = 'http://avaxhome.ws'
PAGE_COUNT = 20

# puts "The argument value is: #{ARGV[0]}" 
FILENAME = 'avax_index.txt'

url = BASE_URL

file_content = ""
counter = 1

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

File.open( FILENAME , 'w') {|f| f.write(file_content) }
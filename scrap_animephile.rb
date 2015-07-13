require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'cgi'
 
 
homepage = 'http://www.animephile.com/hentai'
# 'http://www.animephile.com/hentai/birthday.html?ch=Volume+01'
page = Nokogiri::HTML(open(  homepage     ))  

result_filename = "animephile_last.txt"


results = page.css("#newesthentai div.boxhighlights-item a")

file_content = [] 


results.each do |result|
    element = []
    title = result.text
    link  = "#{result.attributes['href'].value}"
    
    
    
    file_content << [ title, link ]  
end

# puts file_content
  

def download_image( title , url) 
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
    
    puts "Total images: #{images.count}"

end

download_image( file_content.first[0], file_content.first[1])



# http://webtunnel.org/browse.php?u=JKrSes%2BCnO%2B6CZVi08zZv9xAyY4WN%2BiuoG4UGw%3D%3D&b=29&f=norefer   << tunnel from this

# File.open(result_filename , 'w') {|f| f.write(file_content.first[1]) }
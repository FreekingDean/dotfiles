require 'nokogiri'
require 'open-uri'

base_url = 'http://www.dontevenreply.com'

page = Nokogiri::HTML(open("#{base_url}/all.php"))
paths = page.search('a').map { |link| link[:href] }
email_path = paths.select { |path| path.start_with?('view.php?post=') }.uniq.sample

email_page = Nokogiri::HTML(open("#{base_url}/#{email_path}"))
title = email_page.search('.mainpost_header').children.first.to_s.strip
subtitle = email_page.search('.mainpost_ad').children.map{|c| c.text.to_s}.join("\n").strip
content = email_page.search('.mainpost_content').children.map{|c| c.text.to_s}.select{|w| w.strip != ''}.join("\n").strip

puts "Title: #{title}"
puts
puts subtitle
puts
puts content


require 'open-uri'
require 'json'

coursera = Platform.create(name: 'Coursera', logo_url: "https://d3q6qq2zt8nhwv.cloudfront.net/platform/4b9a27f7ca854bbd9a245d55310bc727.png")

result = JSON.parse(open("https://api.coursera.org/api/catalog.v1/categories?includes=courses").read)['elements']

result.each do |category|
  cat = Category.create(name: category['name'])
  category['links']['courses'].each do |course_id|
    begin
      course = JSON.parse(open("https://api.coursera.org/api/catalog.v1/courses/#{course_id}").read)['elements'][0]
      Course.create(name: course['name'], url: "https://www.coursera.org/course/#{course['shortName']}", category_id: cat.id, platform_id: coursera.id, photo_url: "http://designmodo.github.io/Flat-UI/img/icons/svg/book.svg")
    rescue OpenURI::HTTPError => ex
      next
    end
  end
end



codeschool = Platform.create(name: 'CodeSchool', logo_url: "http://kevinhamiltonsmith.com/wp-content/uploads/2013/05/code_school.png")

category = Category.find(15)
require 'nokogiri'
doc = Nokogiri::HTML(open("https://www.codeschool.com/courses"))

array_elements = doc.css('article').map{|x| x.children}

array_elements.each do |el|
  course = {photo_url: el.css('img')[0].attributes['src'].value,
    url: "http://codeschool.com#{el[1].children[1].attributes['href'].value}",
    name: el.children[5].children[1].children[0].text, platform_id: codeschool.id}
  category.courses.create(course)
  puts "SEEDED"
end




codecademy = Platform.create(name: 'Codecademy', logo_url: "http://cdn-production.codecademy.com/assets/logo/logo--dark-blue-bf11002ce1caecdfb9fec8d3286b8a8d.svg")
codecademydoc = Nokogiri::HTML(open("http://www.codecademy.com/learn"))

 category = Category.find(15)
 articles = codecademydoc.css('article').map{|x| x.children}
 articles.shift(2)
 articles = articles[0..2]

 articles.each do |article|
  begin
    course={
      url: "http://www.codecademy.com/#{article[5].attributes['href'].value}",
      name: article.children[4].children.text.gsub("\n", "").gsub("  ", ""),
      photo_url: article[1].children[1].children[1].attributes['src'].value,
      platform_id: codecademy.id}
      category.courses.create(course)
  rescue OpenURI::HTTPError => ex
    next
  end
end



require "nokogiri"
require "watir"
require 'pp'


#TODO Try to get article divs one by one instead of trying to do this one or the other push to array method
# this will make things less complicated and alot easier to work with in terms of data collection

# only take the is-selected img div because for some reason the images are stacked up beside eachother

BRANDS = [
    'rolex',
    'audemarspiguet',
    'breitling',
    'iwc',
    'jaegerlecoultre',
    'omega',
    'panerai',
    'patekphilippe',
    'cartier',
    'gucci',
    'seiko',
    'movado',
    'zenith'
]

browser = Watir::Browser.new(:chrome)

BRANDS.each do |brand|

    urls = [
        "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=1",
        "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=2",
        "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=3",
        "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=4",
        "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=5",
        "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=6"
    ]


    ## article divs select doc.css("#wt-watches .article-item-container")
    ## take the css of the article div and get the name with test.css("div .text-ellipsis")[0].text
    ## take the css of the article fiv and get the price with test.css("div .text-bold")[1].text


    urls.each do |url|
        browser.goto("#{url}")
        sleep 2
        15.times do |i|
            browser.execute_script("window.scrollBy(0,750)")
            sleep 1
        end
        doc = Nokogiri::HTML.parse(browser.html)

        doc.css("#wt-watches .article-item-container").each do |element|
            next if !element

            name = element.css(".text-bold")[0]&.children&.text
            next if !name
            pp name
            image_url = element.css(".content img")[0]['src']
            next if !image_url
            pp image_url
            price = element.css(".text-bold")[1].children.text
            next if !price
            price = price.gsub(/[^0-9]/, "")
            pp price

            File.open("data/#{brand}.txt", "a+") do |f|
                f.puts("#{image_url},#{price}")
            end
        end
    end
end

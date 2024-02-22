require "nokogiri"
require "watir"

BRANDS = [
    'iwc',
    'rolex'
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

    urls.each do |url|
        browser.goto("#{url}")
        sleep 2
        15.times do |i|
            browser.execute_script("window.scrollBy(0,500)")
            sleep 1
        end
        doc = Nokogiri::HTML.parse(browser.html)
        article_divs = doc.css(".article-item-container")
        article_divs.each do |article_div|
            image_div = article_div.at_css("js-carousel-cell carousel-cell d-flex is-selected .content img")
            price_text = doc.css(".m-b-1 div .text-bold")[0].text.strip
            next if !image_div || !price_text

            image_url = image_div['src']
            price_number = price_text.gsub!(/[^0-9,]/, "")

            next if image_url.empty? || price.empty?

            File.open("data/#{brand}.txt", "a+") do |f|
                f.puts("#{image_url},#{price}")

            end
        end
    end


end

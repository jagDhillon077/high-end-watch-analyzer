require "nokogiri"
require "watir"
require 'pp'

# Define an array of brands to scrape
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

# Create a new Chrome browser instance
browser = Watir::Browser.new(:chrome)

# Loop through each brand
BRANDS.each do |brand|

  # Define an array of urls to scrape for the current brand
  urls = [
    "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=1",
    "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=2",
    "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=3",
    "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=4",
    "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=5",
    "https://www.chrono24.ca/#{brand}/index.htm?goal_suggest=6"
  ]

  # Loop through each url for the current brand
  urls.each do |url|
    # Navigate to the current url
    browser.goto("#{url}")

    # Wait for 2 seconds to allow the page to load
    sleep 2

    # Scroll down the page 15 times, each time scrolling by 750 pixels
    15.times do |i|
      browser.execute_script("window.scrollBy(0,750)")
      sleep 1
    end

    # Parse the HTML content of the page using Nokogiri
    doc = Nokogiri::HTML.parse(browser.html)

    # Find all watch elements on the page
    doc.css("#wt-watches .article-item-container").each do |element|
      # Skip if the element is nil
      next if !element

      # Extract the watch name
      name = element.css(".text-bold")[0]&.children&.text
      # Skip if the name is nil
      next if !name
      # Pretty print the name
      pp name

      # Extract the image url
      image_url = element.css(".content img")[0]['src']
      # Skip if the image url is nil
      next if !image_url
      # Pretty print the image url
      pp image_url

      # Extract the price
      price = element.css(".text-bold")[1].children.text
      # Skip if the price is nil
      next if !price
      # Remove all non-numeric characters from the price
      price = price.gsub(/[^0-9]/, "")
      # Pretty print the price
      pp price

      # Open the data file for the current brand in append mode
      File.open("data/#{brand}.txt", "a+") do |f|
        # Write the image url and price to the file, separated by a comma
        f.puts("#{image_url},#{price}")
      end
    end
  end
end

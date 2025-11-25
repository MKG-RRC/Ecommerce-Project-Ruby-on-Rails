require "open-uri"
require "nokogiri"

module Seed
  # Simple scraper to pull product titles and prices from a public catalog site.
  # Uses Books to Scrape as a predictable source: https://books.toscrape.com
  class ProductScraper
    BASE_URL = "https://books.toscrape.com"
    CategoryLink = Struct.new(:name, :href)

    def initialize(category_limit: 4, total_limit: 120)
      @category_limit = category_limit
      @total_limit = total_limit
    end

    def scrape
      collected = []
      categories = fetch_categories.first(@category_limit)

      categories.each do |cat|
        break if collected.size >= @total_limit
        cat_products = scrape_category(cat, remaining: @total_limit - collected.size)
        collected.concat(cat_products.map { |prod| prod.merge(category: cat.name) })
      end

      collected
    rescue StandardError => e
      warn "Seed::ProductScraper failed: #{e.class} - #{e.message}"
      []
    end

    private

    def fetch_categories
      doc = parsed_doc(BASE_URL)
      doc.css(".side_categories ul li ul li a").map do |link|
        CategoryLink.new(link.text.strip, absolutize(link["href"]))
      end
    end

    def scrape_category(cat_link, remaining:)
      doc = parsed_doc(cat_link.href)
      products = []

      doc.css(".product_pod").first(remaining).each do |pod|
        title = pod.css("h3 a").attr("title")&.value&.strip
        price_text = pod.css(".price_color").text.gsub("£", "").strip
        price = BigDecimal(price_text) rescue nil

        products << {
          name: title.presence || "Untitled Product",
          price: price || BigDecimal("0"),
          description: nil
        }
      end

      products
    end

    def parsed_doc(url)
      Nokogiri::HTML(URI.open(url))
    end

    def absolutize(path)
      return path if path.start_with?("http")
      URI.join(BASE_URL, path).to_s
    end
  end
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"
require Rails.root.join("app/lib/seed/product_scraper")

AdminUser.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end if Rails.env.development?

Page.find_or_create_by!(slug: "about") do |page|
  page.title = "About Us"
  page.content = "Write something about your company..."
end

Page.find_or_create_by!(slug: "contact") do |page|
  page.title = "Contact Us"
  page.content = "Contact info here..."
end

# --- Categories & Products ---
scraper = Seed::ProductScraper.new(category_limit: 4, total_limit: 120)
scraped_products = scraper.scrape

category_names = scraped_products.map { |p| p[:category] }.compact.uniq.first(4)
category_names = %w[Books Fiction Nonfiction Comics] if category_names.empty?
categories = category_names.map { |name| Category.find_or_create_by!(name: name) }

product_payloads = scraped_products
needed = 100 - product_payloads.size
if needed.positive?
  filler = Array.new(needed) do
    {
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 5.0..120.0),
      description: Faker::Commerce.material,
      category: category_names.sample
    }
  end
  product_payloads.concat(filler)
end

product_payloads.first(120).each_with_index do |prod, idx|
  category = categories[idx % categories.size]
  name = prod[:name].presence || Faker::Commerce.product_name

  Product.find_or_create_by!(name: name, category: category) do |p|
    p.price = prod[:price].presence || Faker::Commerce.price(range: 5.0..120.0)
    p.description = prod[:description].presence || Faker::Lorem.paragraph(sentence_count: 2)
  end
end

class Product < ApplicationRecord
  belongs_to :category

  has_many_attached :images

  # Ransack allowlist for ActiveAdmin filters
  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "price", "category_id", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "images_attachments", "images_blobs"]
  end
end

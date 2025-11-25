class Page < ApplicationRecord
  has_rich_text :content

  # Allowlist attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "created_at", "updated_at"]
  end

  # Allowlist associations
  def self.ransackable_associations(auth_object = nil)
    ["rich_text_content"]
  end
end

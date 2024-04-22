class Post < ApplicationRecord
  has_many :comments
  has_and_belongs_to_many :tags
  has_one_attached :thumbnail
  has_rich_text :content
end

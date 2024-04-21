class Post < ApplicationRecord
  has_many :comments
  has_one_attached :thumbnail
  has_rich_text :content
end

class Article < ApplicationRecord
  validates :content, presence: true
end

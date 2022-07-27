class Article < ApplicationRecord
  validates :title, presence: true , length: { minimum: 2, maximum: 10 }
  validates :description, presence: true, length: { minimum: 3, maximum: 20 }
end

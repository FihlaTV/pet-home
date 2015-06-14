class Post < ActiveRecord::Base
  belongs_to :category
  scope :adoption, -> {joins(:categories).where("categories.name = 'Adoption'")}
end

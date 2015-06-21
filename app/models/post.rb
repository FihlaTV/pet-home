class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  scope :adoption, -> {joins(:categories).where("categories.name = 'Adoption'")}
  scope :petsitter, -> {joins(:categories).where("categories.name = 'Pet Sitters'")}
  scope :sitterswanted, -> {joins(:categories).where("categories.name = 'Sitters Wanted'")}
  scope :other, -> {joins(:categories).where("categories.name = 'Other'")}
  default_scope { order('created_at DESC') }
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  scope :adoption, -> {joins(:category).where("categories.name = 'Adoption'")}
  scope :petsitters, -> {joins(:category).where("categories.name = 'Pet Sitters'")}
  scope :sitterswanted, -> {joins(:category).where("categories.name = 'Sitters Wanted'")}
  scope :other, -> {joins(:category).where("categories.name = 'Other'")}
  default_scope { order('created_at DESC') }


  validates :user_id, presence: true
  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: {minimum: 20 }, presence: true
  validates :topic, presence: true

end

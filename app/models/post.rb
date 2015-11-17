class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  searchkick
  belongs_to :user
  belongs_to :category

  belongs_to :location
   accepts_nested_attributes_for :location,                 
                                  allow_destroy: true

  has_many :postattachments, dependent: :destroy

  default_scope { order('created_at DESC') }


  validates :user_id, presence: true
  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true


end

class Post < ActiveRecord::Base
  searchkick
  belongs_to :user
  belongs_to :category

  has_one :location, dependent: :destroy

  accepts_nested_attributes_for :location, 
                                
                                 allow_destroy: true




  default_scope { order('created_at DESC') }


  validates :user_id, presence: true
  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true


end

class Post < ActiveRecord::Base
  searchkick
  belongs_to :user
  belongs_to :category

  belongs_to :post


  default_scope { order('created_at DESC') }


  validates :user_id, presence: true
  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: { minimum: 20 }, presence: true


end

class Location < ActiveRecord::Base
  has_many :posts
  belongs_to :user

  validates :street, format: { with: /\A[a-z0-9\s]+\z/i, allow_blank: true }           
  validates :city, presence: true
  validates :zipcode, presence: true,
             format: { with: /\A\d{5}\z/i }
  validates :state, presence: true

  def full_address
    [street, city, zipcode, state].join(", s")
  end

  
end

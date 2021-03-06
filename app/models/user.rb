class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  has_many :posts, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false}
  has_secure_password
  
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
                                
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost:cost)                                               
  end    

  def User.new_token
    SecureRandom.urlsafe_base64
  end   

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end     

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end  

  def forget
    update_attribute(:remember_digest, nil)
  end  

  def activate 
    update_columns(activated: true, activated_at: Time.zone.now)
  end  

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest:  User.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.name = auth.info.name unless user.name != nil
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email unless user.email != nil
        user.image = auth.info.image unless user.image != nil
        user.activated = true
        user.password = SecureRandom.urlsafe_base64 unless user.password != nil
        user.save!
      end
    end
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end

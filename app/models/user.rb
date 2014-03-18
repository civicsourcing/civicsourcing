class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :history

  devise :database_authenticatable, :lockable, :registerable, # :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 

  acts_as_member
  acts_as_follower

  flexible_feeds

  belongs_to :upload

  validates :username, presence: true, uniqueness: { case_sensitive: false },
    length: { in: 3..30 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :gender, presence: true, inclusion: { in: ["male", "female"] }

  before_save :ensure_authentication_token
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end

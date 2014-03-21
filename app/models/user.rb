class User < ActiveRecord::Base
  has_merit

  extend FriendlyId
  friendly_id :username, use: :history

  devise :database_authenticatable, :lockable, :registerable, # :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 

  acts_as_member
  acts_as_follower
  acts_as_voter

  flexible_feeds

  belongs_to :upload

  has_many :events, as: :creator, class_name: "FlexibleFeeds::Event"
  has_many :comments, through: :events, source: :eventable,
    source_type: "Comment"
  has_many :posts, through: :events, source: :eventable,
    source_type: "Post"
  has_many :founded_communities, through: :events, source: :eventable,
    source_type: "Community"
  has_many :founded_initiatives, through: :events, source: :eventable,
    source_type: "Initiative"

  validates :username, presence: true, uniqueness: { case_sensitive: false },
    length: { in: 3..30 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :gender, presence: true, inclusion: { in: ["male", "female"] }

  before_save :ensure_authentication_token
  after_create :add_welcome_badge
 
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

  def add_welcome_badge
    add_badge(0)
  end
end

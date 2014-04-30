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

  def customer
    Balanced::Customer.find(customer_href) if customer_href?
  end

  def find_or_register_customer(params)
    if customer.present? && underwritten?
      customer
    else
      register_customer(params)
    end
  end

  def register_customer(params)
    customer = Balanced::Customer.new(
      name: params[:name],
      email: email,
      dob_month: params[:dob_month],
      dob_year: params[:dob_year],
      address: {
        line1: params[:line1],
        city: params[:city],
        state: params[:state],
        postal_code: params[:postal_code]
      }
    ).save
    update_column(:customer_href, customer.href)
    customer
  end

  def underwritten?
    customer.merchant_status == "underwritten"
  end

  def card_registered?
    customer.try(:source) != nil
  end

  def bank_registered?
    customer.try(:destination) != nil
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

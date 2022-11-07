class User < ActiveRecord::Base

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :received_comments, :class_name => "Profilecomment", :foreign_key => "user_id"
  has_many :given_comments, :class_name => "Profilecomment", :foreign_key => "commenter_id"

  has_many :days, dependent: :destroy

  has_many :notes, dependent: :destroy
  has_many :measurements, dependent: :destroy

  has_many :mealdishes
  has_many :dictnutrs
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  validates :email, 
         presence: true,
         uniqueness: true
  
  validates :username, 
         presence: true,
         uniqueness: true
  
  def self.authenticate(email, password)
    #user = find_by_email(email)
    user = User.where("lower(email) = ?", email.downcase).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end


def self.search(query)
  where("username like ?", "%#{query}%") 
end


 def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

end
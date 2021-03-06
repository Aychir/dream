class User < ApplicationRecord
  attr_accessor :login
  #Make this segment both getter and setter 

  #attr_accessor :updating_password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  #Creates an OBJECT/TABLE for when our user is being followed by another
  #This table has user_id (current user) and following_id (user that follows current user)
  has_many :followers, through: :follower_relationships, source: :follower
  #Allows access to user's followers through the object
  #This connects users following current user to the following_id of the relationship object (look at rails example with patients, section 2.4)

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following
  #Creates an object for when the user follows another one from the follow model

  has_many :blocker_relationships, foreign_key: :blocking_id, class_name: 'Block'
  has_many :blockers, through: :blocker_relationships, source: :blocker

  has_many :blocking_relationships, foreign_key: :blocker_id, class_name: 'Block'
  has_many :blocking, through: :blocking_relationships, source: :blocking

  has_many :reports
  has_many :reports, as: :reported

  has_many :posts

  has_many :votes
  has_many :liked_posts, through: :votes

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  #devise says to add this if we want to allow sign up with username

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validates :email, presence: true, format: Devise.email_regexp

  #validates :password, presence: true, if: lambda {new_record? || !password.blank?}

  def follow(user)
      following_relationships.create(following_id: user)
  end

  def unfollow(user)
        following_relationships.find_by(following_id: user).destroy
    #This shouldn't occur if users can't follow themselves, but added as a precaution
  end

  def block(user)
      blocking_relationships.create(blocking_id: user)
  end

  def unblock(user)
      blocking_relationships.find_by(blocking_id: user).destroy
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        conditions[:email].downcase! if conditions[:email]
        where(conditions.to_h).first
      end
  end

  def send_reset_password_instructions
    return false if self.confirmed_at == nil
    super
  end
end



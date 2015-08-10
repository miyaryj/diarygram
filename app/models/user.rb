class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :instagram_user, class_name: Instagram::User, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :users_followers, foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :users_followers, source: :follower

  has_many :users_followed_users, foreign_key: :follower_id,
    class_name:  ::UsersFollower, dependent:   :destroy
  has_many :followed_users, through: :users_followed_users, source: :followed

  def name
    if instagram_user
      instagram_user.name
    else
      email
    end
  end

  def timeline_entries
    Entry.where(user_id: id).order(:created_at)
  end

  def following?(other)
    users_followed_users.find_by(followed_id: other.id)
  end

  def follow!(other)
    users_followed_users.create!(followed_id: other.id)
  end

  def unfollow!(other)
    users_followed_users.find_by(followed_id: other.id).destroy
  end
end

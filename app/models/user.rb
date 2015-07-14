class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :instagram_user, class_name: Instagram::User, dependent: :destroy
  has_many :entries, dependent: :destroy

  def timeline_entries
    Entry.where(user_id: id).order(:created_at)
  end
end

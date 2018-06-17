class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]


  has_many :user_roles_users
  has_many :user_roles, through: :user_roles_users
  has_many :kommunities
  has_many :events


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    # the token is access_token.user.credentials
    # Create the user if not already present
    unless user
        user = User.create(
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end


end

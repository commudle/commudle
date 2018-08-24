class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]


  has_many :user_roles_users
  has_many :user_roles, through: :user_roles_users
  has_many :kommunities
  has_many :events
  has_many :data_forms
  has_many :event_data_form_entity_groups
  has_many :data_form_entity_response_groups
  has_many :event_entry_passes
  has_many :event_entry_passes, foreign_key: :created_by_id


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    # the token is access_token.user.credentials
    # Create the user if not already present
    unless user
        user = User.create(
           name: "#{data['first_name']} #{data['last_name']}",
           email: data['email'],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end


end

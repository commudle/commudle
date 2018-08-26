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

  after_create :assign_default_role


  def assign_default_role
    self.user_roles << UserRole.default_role
  end


  def self.from_omniauth(access_token)
    data = access_token.info
    return User.find_or_create(data['email'], "#{data['first_name']} #{data['last_name']}", )
  end


  def self.find_or_create(email, name = nil, password = Devise.friendly_token[0,20])
    user = User.where(email: email).first
    # the token is access_token.user.credentials
    # Create the user if not already present
    unless user
      user = User.create(
          email: email,
          name: name,
          password: password
      )
    end
    user
  end


  def organizer?(kommunity_id)
    return self.user_roles_users.includes(:user_role).select{|uru| uru.kommunity_id == kommunity_id && uru.user_role.name == NameValues::UserRoleType::ORGANIZER }.length > 0
  end



  def role?(role_sym, kommunity_id)
    user_roles_users.includes(:user_role).any? { |r| r.user_role.name.underscore.to_sym == role_sym && r.kommunity_id == kommunity_id }
  end


end

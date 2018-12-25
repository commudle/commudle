class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable, , :registerable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]



  has_many :user_roles_users
  has_many :user_roles, through: :user_roles_users
  has_many :kommunities
  has_many :events
  has_many :data_forms
  has_many :event_data_form_entity_groups
  has_many :data_form_entity_response_groups
  has_many :event_entry_passes
  has_many :event_entry_passes, foreign_key: :created_by_id
  has_many :comments
  has_many :user_event_locations
  has_many :fixed_email_edfegs
  has_many :event_updates
  has_many :discussion_followers

  has_one_attached :profile_image



  after_create :assign_default_role


  def assign_default_role
    self.user_roles << UserRole.default_role
  end


  def self.from_omniauth(access_token)
    data = access_token.info
    return User.find_or_create(data['email'], "#{data['first_name']} #{data['last_name']}", data['image'])
  end


  def self.find_or_create(email, name = nil, image = nil, password = Devise.friendly_token[0,20])
    user = User.where(email: email).first
    # the token is access_token.user.credentials
    # Create the user if not already present
    unless user
      user = User.create(
          email: email,
          name: name,
          password: password,
      )
    end
    (user.name != name && (!user.name.blank? || !name.blank?)) ? user.update(name: name) : user.name
    (user.default_image != image && (!user.default_image.blank? || !image.blank?)) ? user.update(default_image: image) : user.default_image



    return user
  end


  def update_info(profile_image: nil, personal_website: nil, about_me: nil, linkedin_profile: nil, twitter_profile: nil, github_profile: nil, designation: nil)
    user = self
    !profile_image.blank? ? user.profile_image.purge : ''
    !profile_image.blank? ? user.profile_image.attach(profile_image) : ''
    !personal_website.blank? ? (user.update(personal_website: personal_website)) : ''
    !linkedin_profile.blank? ? (user.update(linkedin: linkedin_profile)) : ''
    !about_me.blank? ? (user.update(about_me: about_me)) : ''
    !twitter_profile.blank? ? (user.update(twitter: twitter_profile)) : ''
    !github_profile.blank? ? (user.update(github: github_profile)) : ''
    !designation.blank? ? (user.update(designation: designation)) : ''

    return user
  end


  def organizer_kommunities
    roles = self.user_roles_users.joins(:user_role).where('user_roles.name = ?', NameValues::UserRoleType::ORGANIZER)

    return Kommunity.where(id: roles.map(&:kommunity_id))
  end


  def organizer?(kommunity_id)
    return self.user_roles_users.includes(:user_role).select{|uru| uru.kommunity_id == kommunity_id && uru.user_role.name == NameValues::UserRoleType::ORGANIZER }.length > 0
  end



  def role?(role_sym, kommunity_id)
    user_roles_users.includes(:user_role).any? { |r| r.user_role.name.underscore.to_sym == role_sym && (role_sym == :system_administrator || r.kommunity_id == kommunity_id) }
  end


  def avatar
    return self.profile_image.attached? ? self.profile_image : self.default_image
  end


end

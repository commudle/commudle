class UserRole < ApplicationRecord
  has_many :user_roles_users
  has_many :users, through: :user_roles_users


  def self.default_role
    return UserRole.find_by_name("member")
  end
end

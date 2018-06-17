class UserRole < ApplicationRecord
  has_many :user_roles_users
  has_many :users, through: :user_roles_users
end

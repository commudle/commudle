class UserRole < ApplicationRecord
  has_many :user_user_roles
  has_many :users, through: :user_user_roles
end

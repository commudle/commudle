class UserRolesUser < ApplicationRecord
  belongs_to :user
  belongs_to :user_role
  belongs_to :kommunity, optional: true
end

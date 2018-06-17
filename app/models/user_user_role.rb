class UserUserRole < ApplicationRecord
  belongs_to :user
  belongs_to :user_role
end

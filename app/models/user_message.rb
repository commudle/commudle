class UserMessage < ApplicationRecord
  belongs_to :user
  belongs_to :parent, polymorphic: true
end

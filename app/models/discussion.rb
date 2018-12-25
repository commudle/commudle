class Discussion < ApplicationRecord
  belongs_to :user
  belongs_to :parent, polymorphic: true


  has_many :user_messages, as: :parent
  has_many :discussion_followers


end

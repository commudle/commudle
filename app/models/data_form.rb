class DataForm < ApplicationRecord
  belongs_to :parent, polymorphic: true
  belongs_to :user
end

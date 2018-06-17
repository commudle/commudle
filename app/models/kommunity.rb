class Kommunity < ApplicationRecord
  belongs_to :user
  has_many :data_forms
end

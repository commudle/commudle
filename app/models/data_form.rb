class DataForm < ApplicationRecord
  belongs_to :user
  belongs_to :kommunity
  has_many :questions, dependent: :destroy

  accepts_nested_attributes_for :questions, reject_if: lambda { |q| q[:title].blank? }, allow_destroy: true
end

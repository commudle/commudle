class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :data_form
  has_many :form_responses, as: :parent

  has_many :question_choices, dependent: :destroy

  accepts_nested_attributes_for :question_choices, reject_if: lambda { |q| q[:title].blank? }, allow_destroy: true
end

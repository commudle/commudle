class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :data_form

  has_many :question_choices, dependent: :destroy
  has_many :data_form_entity_response_values

  accepts_nested_attributes_for :question_choices, reject_if: lambda { |q| q[:title].blank? }, allow_destroy: true

  default_scope { order(created_at: :asc) }
end

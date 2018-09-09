class QuestionChoice < ApplicationRecord
  acts_as_paranoid

  belongs_to :question
  has_many :data_form_entity_response_values
end

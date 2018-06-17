class QuestionChoice < ApplicationRecord
  belongs_to :question
  has_many :form_responses, as: :parent
end

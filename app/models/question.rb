class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :form
  has_many :form_responses, as: :parent
end

class FormResponse < ApplicationRecord
  belongs_to :user
  belongs_to :data_form_entity
  # parent is either a question or a choice
  belongs_to :parent, polymorphic: true
end

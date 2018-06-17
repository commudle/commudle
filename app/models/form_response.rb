class FormResponse < ApplicationRecord
  belongs_to :user
  belongs_to :data_form_entity
  belongs_to :parent, polymorphic: true
end

class FixedEmailEdfeg < ApplicationRecord
  belongs_to :fixed_email
  belongs_to :user
  belongs_to :event_data_form_entity_group
end

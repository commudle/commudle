class FixedEmail < ApplicationRecord
  has_many :fixed_email_dfe_response_groups
  has_many :data_form_entity_response_groups, through: :fixed_email_dfe_response_groups


  has_many :fixed_email_entry_passes


end

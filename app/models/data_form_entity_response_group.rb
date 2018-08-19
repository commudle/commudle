class DataFormEntityResponseGroup < ApplicationRecord
  belongs_to :user
  belongs_to :event_data_form_entity_group
  belongs_to :registration_status, optional: true

  has_many :data_form_entity_responses

  has_many :fixed_email_dfe_response_groups
  has_many :fixed_emails, through: :fixed_email_dfe_response_groups


  # setting the default value of registration_status
  # attribute :registration_status, :integer, default: RegistrationStatus.find_by_name("waiting")

end

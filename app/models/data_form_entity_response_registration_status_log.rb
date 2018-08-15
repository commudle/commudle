class DataFormEntityRegistrationStatusLog < ApplicationRecord
  # here user is the person who updated the status
  belongs_to :user
  belongs_to :data_form_entity_response
  belongs_to :registration_status






end
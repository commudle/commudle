class DataFormEntityResponseGroup < ApplicationRecord
  belongs_to :user
  belongs_to :event_data_form_entity_group
  belongs_to :registration_status, optional: true

  has_many :data_form_entity_responses

  has_many :fixed_email_dfe_response_groups
  has_many :fixed_emails, through: :fixed_email_dfe_response_groups


  # setting the default value of registration_status
  # attribute :registration_status, :integer, default: RegistrationStatus.find_by_name("waiting")


  def self.send_rsvp_email(dferg_ids, subject, message)
    dferg_ids.each do |dferg|
      EventCommunicationMailer.rsvp_email(dferg, subject, message).deliver_now
    end

  end


  def rsvp_link(type)
    type == "confirmed" ? change_responses_registration_type_path(token: self.rsvp_token, rsvp_status: "1") : change_responses_registration_type_path(token: self.rsvp_token, rsvp_status: "0")
  end


  def fixed_email_sent?(type)
    fixed_emails = self.fixed_emails
    if(fixed_emails.map(&:type) == type)
      return true, fixed_emails.length
    end


    return false, 0
  end

end

class DataFormEntityResponseGroup < ApplicationRecord
  belongs_to :user
  belongs_to :event_data_form_entity_group
  belongs_to :registration_status, optional: true

  has_many :data_form_entity_responses
  has_many :fixed_email_dfe_response_groups
  has_many :fixed_emails, through: :fixed_email_dfe_response_groups
  has_many :track_slots
  # speaker resources would be created only once a speaker is shortlisted for a session
  has_one :speaker_resource


  delegate :event, :to => :event_data_form_entity_group, :allow_nil => true


  # setting the default value of registration_status
  attribute :registration_status_id, :integer, default: RegistrationStatus.find_by(name: "registered").id


  # scopes
  scope :with_responses, -> {includes(:data_form_entity_responses)}

  ##


  # this method should go to the resque_worker
  def self.send_rsvp_email(dferg_ids, subject, message, force = false, event_details_options = {})
    dfergs = DataFormEntityResponseGroup.includes(:registration_status, :user).where("id in (?)", dferg_ids)

    dfergs.each do |dferg|
      if(force || ((!NameValues::RegistrationStatusType::RSVP_DONE.include?(dferg.registration_status.name)) && dferg.fixed_email_sent?(NameValues::FixedEmailType::RSVP)[0] == false))
        Resque.enqueue(RsvpMailerWorker, dferg.id, subject, message, event_details_options)
        # RsvpMailerWorker.perform( dferg.id, subject, message, event_details_options)
      end
    end

  end


  def self.send_entry_pass_email(dferg_ids, subject, message, force = false, event_details_options = {})

    dfergs = DataFormEntityResponseGroup.includes(:registration_status, :user).where("id in (?)", dferg_ids)

    dfergs.each do |dferg|

      EventEntryPass.find_or_create(dferg.event_data_form_entity_group.event, dferg.user, CurrentAccess.user)

      if(force || dferg.fixed_email_sent?(NameValues::FixedEmailType::ENTRY_PASS)[0] == false)
      Resque.enqueue(EntryPassMailerWorker, dferg.id, subject, message, event_details_options)
      end
    end
  end


  def rsvp_link(type)
    type == "confirmed" ? change_responses_registration_type_path(token: self.rsvp_token, rsvp_status: "1") : change_responses_registration_type_path(token: self.rsvp_token, rsvp_status: "0")
  end


  def fixed_email_sent?(type)
    fixed_emails = self.fixed_emails
    if(fixed_emails.map(&:mail_type).include? type)
      return true, fixed_emails.length
    end
    return false, 0
  end


  def fixed_emails_delivered_types
    return self.fixed_emails.map(&:mail_type)
  end


  def registration_status?(registration_status_names)
    return registration_status_names.include? self.registration_status.name
  end



end

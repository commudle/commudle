class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :kommunity
  belongs_to :user
  belongs_to :event_status

  has_many :event_data_form_entity_groups
  has_many :event_entry_passes
  has_many :event_location_tracks
  has_many :event_locations
  has_many :locations, through: :event_locations
  has_many :comments, as: :commentable

  has_one_attached :header_image



  after_save :create_log, if: :will_save_change_to_event_status_id?

  before_validation :init


  # scopes
  default_scope { includes(:event_status, :kommunity) }
  scope :with_locations, -> {includes(:locations)}
  scope :with_comments, -> {includes(:comments)}

  ##

  def init
    self.event_status  ||= EventStatus.find_by_name(NameValues::EventStatusType::DRAFT)
  end


  def create_log(current_user = nil)
    current_user = CurrentAccess.user.blank? ? current_user : CurrentAccess.user
    if current_user

      EventStatusLog.create(
                        event: self,
                        user: current_user,
                        event_status: self.event_status
      )

    else
      return "Event Status Change Log Not Created"

    end
  end


  def self.upcoming(kommunity_id: nil)

    if(kommunity_id.blank?)
      return Event.joins(:event_status, :kommunity).where(
                      "event_statuses.name = ?",
                      NameValues::EventStatusType::ANNOUNCED
      ).order("start_time asc")
    else
      return Event.joins(:event_status).where(
          "event_statuses.name = ? and kommunity_id = ?",
          NameValues::EventStatusType::ANNOUNCED, kommunity_id
      ).order("start_time asc")
    end

  end


  def status? (event_status_names)
    return event_status_names.include? self.event_status.name
  end

  # change this function to permitted forms
  # send if a user has already filled a form along with the list of permitted forms
  def open_forms

    open_forms = []
    self.event_data_form_entity_groups.each do |edfeg|
      edfeg.data_form_entities.each do |dfe|
        # show only visible forms
        if (dfe.can_fill_event_form(CurrentAccess.user) && !dfe.open_but_invisible?)
          open_forms << dfe
        end
      end
    end

    open_forms

  end


  def start_time
    self[:start_time].blank? ? Time.now : self[:start_time].in_time_zone(self.timezone)
  end


  def end_time
    self[:end_time].blank? ? Time.now : self[:end_time].in_time_zone(self.timezone)
  end



  def shortlisted_speaker_registrations_group
    entity_groups = self.event_data_form_entity_groups.includes(:registration_type, data_form_entity_response_groups: [:user, :registration_status]).joins(:registration_type).where("registration_types.name = ?", NameValues::RegistrationsType::SPEAKER)

    responses = []

    entity_groups.each do |eg|
      responses << eg.data_form_entity_response_groups
    end

    return responses

  end


  def get_available_speakers
    DataFormEntityResponseGroup.includes(:user).joins(:registration_status, event_data_form_entity_group: [:event, :registration_type]).where('events.id = ? and registration_types.name = ? and registration_statuses.name = ?', self.id, NameValues::RegistrationsType::SPEAKER, NameValues::RegistrationStatusType::CONFIRMED)
  end



  # this method should go to the resque_worker
  def send_feedback_emails(form_id, subject, message, force = false)

    self.event_entry_passes.includes(:event).where(attendance: true).each do |eep|

      if (force || eep.fixed_email_sent?(NameValues::FixedEmailType::FEEDBACK)[0] == false)
        Resque.enqueue(FeedbackMailerWorker, eep.id, form_id, subject, message)
      end

    end


  end



end

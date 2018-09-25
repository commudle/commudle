module NameValues
  extend ActiveSupport::Concern

  # put all the names which have to remain static here


  class UserRoleType
    SYS_ADMIN = "system_administrator"
    ORGANIZER = "organizer"
    MEMBER = "member"
  end


  class RegistrationsType
    SPEAKER = "speaker"
    ATTENDEE = "attendee"
    FEEDBACK = "feedback"
  end


  # class RegistrationsTypeFormSubmissionMessages
  #   SPEAKER = "Thank You! We've received your details, someone from the team will get back to you soon on your email!"
  #   ATTENDEE = "Thank You! We've received your details, someone from the team will get back to you soon on your email!"
  #   FEEDBACK = "Thanks for sharing the feedback! Stay tuned to our website for the next event. Stay tuned!"
  # end


  class   RegistrationStatusType
    REGISTERED = "registered"
    WAITING = "waiting"
    SHORTLISTED = "shortlisted"
    CONFIRMED = "confirmed"
    CANCELLED = "cancelled"

    RSVP_DONE = [CONFIRMED, CANCELLED]

  end


  class EventStatusType
    DRAFT = "draft"
    ANNOUNCED = "announced"
    OPEN = "open"
    ONGOING = "ongoing"
    COMPLETED = "completed"
    CANCELED = "canceled"
  end


  class FixedEmailType
    RSVP = "rsvp"
    ENTRY_PASS = "entry_pass"
    FEEDBACK = "feedback"
  end



end
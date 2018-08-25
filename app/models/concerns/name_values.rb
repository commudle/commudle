module NameValues
  extend ActiveSupport::Concern

  # put all the names which have to remain static here


  class UserRoleType
    ORGANIZER = "organizer"
    MEMBER = "member"
    SYS_ADMIN = "system_administrator"

  end


  class RegistrationStatusType
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
    ONGOING = "ongoing"
    COMPLETED = "completed"
    CANCELED = "canceled"
  end


  class FixedEmailType
    RSVP = "rsvp"
    ENTRY_PASS = "entry_pass"
  end



end
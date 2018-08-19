module NameValues
  extend ActiveSupport::Concern

  # put all the names which have to remain static here

  class RegistrationStatus
    WAITING = "waiting"
    SHORTLISTED = "shortlisted"
    CONFIRMED = "confirmed"
    CANCELLED = "cancelled"
  end



end
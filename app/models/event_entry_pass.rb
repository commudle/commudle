class EventEntryPass < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :created_by, class_name: 'User'



  validates :event, uniqueness: { scope: :user }
  validates :unique_code, uniqueness: { scope: :event }


  def self.find_or_create(event, user, created_by, ots = false, uninvited = false, attendance = false)
    entry_pass = EventEntryPass.find_by(event: event, user: user)

    if(entry_pass.blank?)
      entry_pass = EventEntryPass.new(event: event, user: user, created_by: created_by)

    #   generate a code based on the number of seats available (one digit more)
      on_the_spot_registration = ots
      uninvited = uninvited
      attendance = attendance
      entry_pass.unique_code = EventEntryPass.generate_code(event)
      entry_pass.save
    end

    return entry_pass
  end



  def self.generate_code(event)
    unique_code = rand.to_s[2..[(event.seats.digits.length + 1), 2].max]

    while(!EventEntryPass.find_by(event: event, unique_code: unique_code).blank?)
      unique_code = rand.to_s[2..[(event.seats.digits.length + 1), 2].max]
    end

    return unique_code

  end



end

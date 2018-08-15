# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



UserRole.create([{ :name => 'system_administrator' }, { :name => 'organizer'}, { :name => 'member' }])

QuestionType.create([{ :name => 'short_answer' }, { :name => 'long_answer'}, { :name => 'number' }, { :name => 'single_choice' }, { :name => 'multiple_choice' }])


RegistrationStatus.create([{ name: "waiting"}, { name: "shortlisted"}, { name: "confirmed"}, { name: "cancelled"}])

RegistrationType.create([{ name: "attendee"}, { name: "speaker"}, {name: "feedback"}, {name: "communication"}])

EventStatus.create([{ name: "draft"}, { name: "announced"}, {name: "announced_with_email"}, { name: "registrations_open"}, { name: "registrations_closed"}, { name: "rsvp_open"}, { name: "rsvp_closed"}, { name: "entry_passes_rolling_out"}, { name: "entry_passes_completed"}, { name: "ongoing"}, { name: "completed"} ])


RegistrationType.where("name in (?)", ["attendee", "speaker"]).each do |rt|
  RegistrationStatus.all.each do |rst|
    rst.registration_types << rt
  end
end





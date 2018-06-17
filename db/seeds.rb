# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



UserRole.create([{ :name => 'system_administrator' }, { :name => 'organizer'}, { :name => 'member' }])

QuestionType.create([{ :name => 'short_answer' }, { :name => 'long_answer'}, { :name => 'number' }, { :name => 'single_choice' }, { :name => 'multiple_choice' }])





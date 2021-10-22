# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Problem to be solve

# Number of resources are occupied on # of project
# how many developers are partially occupied (search by 20%, 50%, 75% etc)
# how many developers are fully available
# How many developers will be release on upcoming dates
# Top demanding skillsets
# Alert - Example if any employee is about the leave the org, figure out the replacement


# client_array = [
#                 # ra
#                 {title: "ActOnBet", contact_person: "Jimmy", contacts: "9876543210"},
#                 #  Agencies
#                 {title: "Sephora", contact_person: "Kabir", contacts: "+74 394737594"},
#                 {title: "MarketGo", contact_person: "Barbera", contacts: "9876543210"},
#                 # individual
#                 {title: "KodeKloud", contact_person: "Shaun", contacts: "+46 5067865410"},
#                 {title: "Nymcard", contact_person: "Jacob", contacts: "+60 50765410"},
#                 {title: "Smatbulls", contact_person: "Stev", contacts: "+46 503455410"},
#                 ]

# puts "Client Creation ------------------------"
# client_array.each do |client_data|
#   Client.create(client_data)
# end
#
# puts "Project Creation ------------------------"
# client_igaming = Client.find_by(title: "ActOnBet").id
# Project.create!({name: "ActOnBet", category: 0, co_ordinator: "Jimmy", start_at: Time.parse("21-03-2021"), client_id: client_igaming})
#
# client_agency_1 = Client.find_by(title: "Sephora").id
# Project.create!({name: "Sephora | Singapore", category: 1, co_ordinator: "Kin jo", start_at: Time.parse("28-04-2021"), client_id: client_agency_1})
# Project.create!({name: "Sephora | Vietnam", category: 1, co_ordinator: "Phong vo", start_at: Time.parse("01-05-2021"), client_id: client_agency_1})
# Project.create!({name: "Sephora | Japan", category: 1, co_ordinator: "Shin chan", start_at: Time.parse("05-05-2021"), client_id: client_agency_1})
#
# client_individual = Client.find_by(title: "KodeKloud").id
# Project.create!({name: "KodeKloud", category: 2, co_ordinator: "Shaun", start_at: Time.parse("21-03-2021"), client_id: client_individual})
#
# client_individual = Client.find_by(title: "Nymcard").id
# Project.create!({name: "Nymcard", category: 2, co_ordinator: "Jacob", start_at: Time.parse("21-03-2021"), client_id: client_individual})
# Creating employee for admin

Employee.skip_callback(:create, :after, :create_user)
admin_employee = Employee.create!({name: 'Admin', email: DEFAULT_ADMIN_EMAIL, phone: '8087036184', experience: '15', designation: 1})
admin=User.create!({ username: "Admin User", email: admin_employee.email,
               password: 'password', password_confirmation: 'password', role: 'admin', employee_id: admin_employee.id})

backend_skills = ["Ruby on Rails", "Python", "Node", "PHP"]
frontend_skills = ["React", "Angular", "ViuJS"]
(backend_skills + frontend_skills).map do |skill|
  Skill.create({title: skill})
end
#
# first_name = ["Sushant", "Nishant", "Sameer", "Sanjana", "Pavan", "Mahendra", "Nitin", "Sumit", "Vyom", "Kundan", "Jayesh", "Purva", "Kirti", "Saloni", "Suhas"]
# last_name = ["Gupta", "Dubey", "Kishore", "Malik", "Bhojani", "Prasad", "Pandit"]
#
# # Create 10-15 employee of each skills
# Skill.where(title: ["Ruby on Rails","React"]).each do |skill|
#   (10..15).to_a.sample.times do |i|
#     name = [first_name.sample, last_name.sample]
#     full_name = name.join(" ")
#     email = "#{name.join('.')}@fakemail.com"
#     phone = 9876540000 + i
#     # %i[TeamLead TechLead SSE SE]
#     role = [0, 1, 2, 3, 2, 3,3,2].sample
#     experience = [0, 1].include?(role) ? [5,6,7].sample : (0..4).to_a.sample
#
#     development_skill = (experience > 3) ? [4,5].sample : [1,2,3].sample
#     client_management_skill = (experience > 3) ? [3,4,5].sample : [1,2].sample
#     mentorship_skill = (experience > 3) ? [4,5].sample : [1,2,3].sample
#     last_working_day = []
#     50.times {last_working_day << nil}
#     last_working_day << (Date.today + [2,3,4,5].sample.days + [0,1,2].sample)
#     employee = Employee.create!({
#       name: full_name,
#       email: email,
#       phone: phone,
#       designation: role,
#       experience: experience,
#       development_skill: development_skill,
#       client_management_skill: client_management_skill,
#       mentorship_skill: mentorship_skill,
#       last_working_day: last_working_day.sample
#     })
#
#     EmployeeSkill.create!({employee_id: employee.id, skill_id: skill.id, is_primary: true, experience: (0..employee.experience).to_a.sample })
#   end
# end
#
#
#
# # Freelance projects
# comp_first_name = ["Sun", "Star", "Walk", "Go", "Serv", "Omega", "Sigma", "Alpha", "Beta", "Aone", "Rocket", "SpaceBit", "Coin", "Amaz"]
# comp_last_name = ["Tech", "Biz", "Soft", "Technologies", "Solutions", "IT Solutions", "LLC"]
#
# contact_person_first_name = ["James", "Steve", "Nicolas", "Harman", "Bob", "Amilio", "Samanth", "Amber"]
# contact_person_last_name = ["Root", "Lee", "Thomus", "Graham", "Watson"]
#
# internal_client = Client.create({title: "Internal Gammastack", contact_person: "Admin"})
# Project.create({
#   name: "Internal",
#   category: 2,
#   client_id: internal_client.id,
#   start_at: Date.today - 1.year,
#   payment_cycle: 1,
#   working_hours_per_week: 0,
# })
#
# 12.times do |i|
#   client_name = "#{comp_first_name.sample} #{comp_last_name.sample}"
#   contact_person ="#{contact_person_first_name.sample} #{contact_person_first_name.sample}"
#   contact_person_email = contact_person.gsub(" ", ".")+"@fakemail.com"
#   contact = ["+60", "+65", "+1", "+40"].sample + (684395355 + i).to_s
#   address = "Street lane #{(1..24).to_a.sample}, Zip: 32#{(3456..6789).to_a.sample}, USA CA"
#   working_hours_per_week = [30, 35, 40, 80, 120].sample
#   client = Client.create!({title: client_name, contact_person: contact_person, contacts: contact, email: contact_person_email, address: address })
#   Project.create!({
#     name: client_name,
#     category: 2,
#     # co_ordinator: contact_person,
#     client_id: client.id,
#     start_at: (Date.today.last_year..Date.today).to_a.sample,
#     expected_end_date: Date.today + (1..4).to_a.sample.months,
#     working_hours_per_week: working_hours_per_week,
#     profile_name: ["Ramesh T", "Suresh L", "Mayank P", "Junaid S"].sample,
#     skills_required: %w(ruby python react angular vuejs php android ios).sample,
#     payment_cycle: (1..3).to_a.sample,
#     hourly_charge: [20, 22, 25, 30, 35, 40].sample,
#     status: 1,
#     skill_ids: working_hours_per_week > 40 ? [Skill.find_by(title: "Ruby on Rails").id, Skill.find_by(title: "React").id] : 1
#     })
# end
#
# Project.all.each do |project|
#   # team members
#   [1,2,3].sample.times do |i|
#       weekly_occupancy = (5..30).to_a.sample
#       employee_id = Employee.all.pluck(:id).sample
#       EmployeeProject.create({
#         project_id: project.id,
#         employee_id: employee_id,
#         role: [0, 1].sample,
#         weekly_occupancy: weekly_occupancy,
#         start_at: (Date.today.last_year..Date.today).to_a.sample,
#       })
#   end
# end
#
#
# #  create timesheets
# (Date.today.at_beginning_of_month - 2.months..Date.today).each do |date|
#   # create timesheet for each employee on this day
#   # Possible, major development
#
#   next if (date.wday == 0 || date.wday == 6)
#   Employee.all.each do |emp|
#     emp.employee_projects.each do |ep|
#       project = ep.project
#       working_hours = (ep.role == "Developer") ? (3..6).to_a : (1..2).to_a
#       comments = []
#       references = []
#       (3..5).to_a.each do |i|
#         references.push("http://www.#{ep.project.name.downcase.gsub(' ', '')}.com/task/TASK-#{ep.id}#{i}")
#         comments.push("Development started on 1#{ep.id}\nDevelopment is done 2#{ep.id}")
#       end
#
#       next if emp.timelogs_on_day(date).to_f >= 8.0
#       task_type = project.name.downcase == "internal" ? [0,0,1,1,0,4,3,0,1].sample : [0,0,1,1,0,0].sample
#       timesheet = {project_id: project.id, working_hours: working_hours.sample, on_date: date, task_type: task_type, employee_id: emp.id, comments: comments.join("\n"), references: references.join("\n")}
#       Timesheet.create(timesheet)
#     end
#   end
# end
#

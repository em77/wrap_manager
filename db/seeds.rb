# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Client.destroy_all
ClientAction.destroy_all

75.times do
  client = Client.new
  client.first_name = Faker::Name.first_name
  client.last_name = Faker::Name.last_name
  client.save!
end

client_id_array = []
Client.all.each do |client|
  client_id_array << client.id
end

200.times do
  client_action = ClientAction.new
  client_action.wrap_session = [0, 1].sample
  client_action.notes = Faker::Lorem.sentence
  client_action.client_id = client_id_array.sample
  client_action.wrap_action = [:opened, :closed, :completed, :non_wrap,
    :no_change].sample
  random_date = Faker::Date.between(3.months.ago, Date.today)
  client_action.created_at = random_date
  client_action.updated_at = random_date
  client_action.save!
end

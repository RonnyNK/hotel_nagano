# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

view_type_list = [
  "parking",
  "window"
]

view_type_list.each do |name|
  ViewType.create(name: name)
end

room_type_list = [
  "simple",
  "double",
  "executive",
  "presidential"
]

room_type_list.each do |name|
  RoomType.create(name: name)
end

base_rate_list = [
  [100.00, "2020-01-01"],
  [150.00, "2020-01-01"],
  [200.00, "2020-01-01"],
  [250.00, "2020-01-01"],
  [300.00, "2020-01-01"],
  [350.00, "2020-01-01"],
  [400.00, "2020-01-01"],
  [450.00, "2020-01-01"]
]

base_rate_list.each do |rate, date|
  BaseRate.create(rate: rate, date_begin: date)
end

FIRST_FLOOR = 1
SECOND_FLOOR = 2
THIRD_FLOOR = 3

# (name, next_room, floor, room_type, view_type, base_rate)
room_list = [
  ["101", nil, FIRST_FLOOR, 1, 1, 1],
  ["102", 1, FIRST_FLOOR, 2, 1, 3],
  ["103", nil, FIRST_FLOOR, 3, 2, 6],
  ["104", 3, FIRST_FLOOR, 4, 2, 8],
  ["201", nil, SECOND_FLOOR, 1, 2, 2],
  ["202", 5, SECOND_FLOOR, 2, 2, 4],
  ["203", nil, SECOND_FLOOR, 3, 1, 5],
  ["204", 7, SECOND_FLOOR, 4, 1, 7],
  ["301", nil, THIRD_FLOOR, 3, 1, 5],
  ["302", 9, THIRD_FLOOR, 3, 1, 5],
  ["303", nil, THIRD_FLOOR, 4, 2, 8],
  ["304", 11, THIRD_FLOOR, 4, 2, 8],
]

room_list.each do |name, next_door, floor, room_type, view_type, base_rate|
  Room.create(name: name, next_door: next_door, floor: floor, room_type_id: room_type, view_type_id: view_type, base_rate_id: base_rate)
end

day_rate_list = [
  ["monday", 1.00],
  ["tuesday", 1.00],
  ["wednesday", 1.00],
  ["thursday", 1.10],
  ["friday", 1.20],
  ["saturday", 1.25],
  ["sunday", 1.20]
]

day_rate_list.each do |name, rate|
  DayRate.create(name: name, rate:rate)
end

season_rate_list = [
  ["spring", 1.00, "2021-03-20", "2021-06-19"],
  ["summer", 1.30, "2021-06-20", "2021-09-21"],
  ["autumn", 1.00, "2021-09-22", "2021-12-20"],
  ["winter", 1.20, "2021-12-21", "2022-03-19"],
  ["construction", 1.20, "2021-07-18", "2021-07-31"]
]

season_rate_list.each do |name, rate, from_date, to_date|
  SeasonRate.create(name: name, rate: rate, from_date: from_date, to_date: to_date)
end

client_list = [
  ["Ronny", "Nou-Khlot", "ronny.nou-khlot@semiweb.ca"],
  ["Evan", "Hutchinson", "evan.hutchinson@semitweb.ca"],
  ["Greg", "Hubin", "greg.hubin@semiweb.ca"],
  ["Toto", "Tata", "toto.tata@semiweb.ca"]
]

client_list.each do |first_name, last_name, email|
  Client.create(first_name: first_name, last_name: last_name, email: email)
end

# reservation_id, room_id, deleted_at
reserved_room_list = [
  [1, 1, nil],
  [1, 2, "2021-03-21"],
  [2, 2, nil],
  [2, 3, nil],
  [3, 12, nil]
]

reserved_room_list.each do |reservation_id, room_id, deleted_at|
  ReservedRoom.create(reservation_id: reservation_id, room_id: room_id, deleted_at: deleted_at)
end

# client_id, reserved_at, date_in, date_out, demands, billing_id
reservation_list = [
  [1, "2021-02-27", "2021-03-23", "2021-03-30", "none", 2],
  [1, "2021-01-02", "2021-03-14", "2021-03-21", "Chair for baby", 1],
  [2, "2021-02-26", "2021-03-23", "2021-03-30", "Ergonomic table for laptop", 3],
  [2, "2021-02-26", "2021-03-23", "2021-03-30", "none", 3],
  [3, "2021-02-25", "2021-03-23", "2021-03-30", "none", 4]
]

reservation_list.each do |client_id, reserved_at, date_in, date_out, demands, billing_id|
  Reservation.create(client_id: client_id, reserved_at: reserved_at, date_in: date_in, date_out: date_out, demands: demands, billing_id: billing_id)
end

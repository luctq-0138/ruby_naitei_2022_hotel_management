require 'faker'

#User

User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "12345678",
             password_confirmation: "12345678",
             address: "144 Xuan Thuy, Cau Giay, Ha Noi",
             phone_number: "0989470882",
             activated: true,
             role: 1)
10.times do |n|
  name = Faker::Name.name;
  email = Faker::Internet.email(name: name)
  password = "12345678"
  address = Faker::Address.full_address
  phone_number = Faker::PhoneNumber.cell_phone_in_e164
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              address: address,
              phone_number: phone_number,
              activated: true,
              role: 0)
end

#Room Type

image = [
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-1%20(1).jpg?alt=media&token=ee37e09a-cf2d-45cd-aca1-1f698b6bcb86",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-12.jpg?alt=media&token=bc8db994-80e0-493e-ab0f-d9668b566ce5",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-2%20(1).jpg?alt=media&token=da7e6531-56f5-4e1d-a708-3534a3a9dcbd",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-8.jpg?alt=media&token=7d10b914-0410-4789-a8bf-c2d36b248de3",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-6.jpg?alt=media&token=1690b2f7-9ec4-418b-9f1a-b5d187c784cc",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-5.jpg?alt=media&token=5645738a-99f2-4cea-b6ea-9677fc953f2e",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-4.jpg?alt=media&token=39d6d8a1-68af-4980-8133-2ae66827f39c",
  "https://firebasestorage.googleapis.com/v0/b/hotel-management-a5ac1.appspot.com/o/room-3.jpg?alt=media&token=1fc309af-0f29-423a-94aa-8e6736cc725e"
]

room_type_names = ["Premium King Room", "Deluxe Room", "Double Room", "Luxury Room", "Room With View", "Small View"]
(0..5).each do |i|
  cost = Faker::Commerce.price
  size = Faker::Number.between(from: 25, to: 35)
  capacity = Faker::Number.between(from: 2, to: 4)
  star_rate = Faker::Number.between(from: 1, to: 5)
  services = "Wifi, Television, Bathroom,..."
  RoomType.create!(name: room_type_names[i],
                   size: size,
                   capacity: capacity,
                   cost: cost,
                   star_rate: star_rate,
                   image: image[i],
                   services: services,
                   description: Faker::Lorem.paragraph(sentence_count: 30))
end

#Room

room_types = RoomType.all
12.times do |n|
  room_types.each do |room_type|
    number = Faker::Number.between(from: 100, to: 300)
    room_type.rooms.create!(number: number,
                            name: "#{room_type.name} - #{number}")
  end
end

#Booking and Room_booked

rooms = Room.all
time_unit=["days", "weeks"]
users = User.all
20.times do |n|
  booking_date = Faker::Date.backward(days: 14)
  duration_of_stay = "#{Faker::Number.between(from: 1, to: 4)} #{time_unit.shuffle.first}"
  total_rooms_booked = Faker::Number.between(from: 1, to: 4)
  total_amount = Faker::Number.decimal(l_digits: 2)
  user = users.shuffle.first
  booking = user.bookings.create!(booking_date: booking_date,
                           duration_of_stay: duration_of_stay,
                           total_rooms_booked: total_rooms_booked,
                           total_amount: total_amount)
  total_rooms_booked.times do
    booking.room_bookeds.create!(room: rooms[rand(rooms.size)])
  end
end

# Payment

bookings = Booking.all
types = ["online", "offline"]
bookings.each do |booking|
  payment_type = types.shuffle.first
  booking_id = booking.id
  user_id = booking.user_id
  Payment.create!(booking_id: booking_id,
                  payment_type: payment_type,
                  user_id: user_id)
end

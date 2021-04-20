class ClientMailer < ActionMailer::Base
  default from: "hotel_hagano@gmail.com"

  def welcome_email(client)
    @client = client
    mail(:to => client.email, :subject => "Welcome to Hotel Nagano")
  end

  def billing_reservation(client, room_ids)
    @client = client
    @reservation = client.reservations.last
    @reserved_rooms = @reservation.reserved_rooms
    @room_ids = room_ids
    mail(:to => @client.email, :subject => "Your reservation details")
  end
end

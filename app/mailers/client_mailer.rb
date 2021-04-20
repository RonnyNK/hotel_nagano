class ClientMailer < ActionMailer::Base
  default from: "hotel_hagano@gmail.com"

  def welcome_email(client)
    @client = client
    mail(:to => client.email, :subject => "Welcome to Hotel Nagano")
  end

  def billing_reservation(client)
    @client = client
    @reservation = client.reservations.last
    @reserved_rooms = @reservation.reserved_rooms
    @billing = Billing.calculate(@reservation)

    mail(:to => @client.email, :subject => "Your reservation details")
  end
end

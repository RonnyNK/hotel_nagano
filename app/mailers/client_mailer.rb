class ClientMailer < ActionMailer::Base
  default from: "hotel_hagano@gmail.com"

  def welcome_email(client)
    @client = client
    mail(:to => client.email, :subject => "Welcome to Hotel Nagano")
  end
end

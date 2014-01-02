class Ticket
  attr_reader :venue, :date
  attr_accessor :price

  def initialize(venue, date)
  	@venue = venue
  	@date = date
  end

end

ticket = Ticket.new("Town Hall", "11/12/13")
ticket.price=(63.02)

puts "The ticket costs $#{"%.2f" % ticket.price}."
puts "The venue is #{ticket.venue}, on #{ticket.date} "
# feature test to test the creation of journey class
require_relative '../lib/journey'

# creating an instance of journey class

journey = Journey.new
# has a state of in_journey? as false when idle
puts journey.in_journey
# journey instance takes in station instances as paramemeters and
# creates a list of journeys
# in
journey.start(Station.new("Kensington", 2))
# in_ojurney? is true while traveling
puts journey.in_journey
# out
journey.end(Station.new("Trafalgal Square", 1))

#journeys list

print journey.journeys

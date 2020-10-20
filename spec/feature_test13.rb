# feature test to test the creation of station class
# travelled to
require_relative '../lib/station'

# creating new instance

station = Station.new("Kensington", 2)

puts station.name
puts station.zone

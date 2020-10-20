# feature test to make sure that touch_out ccepts and stores station
# travelled to
require_relative '../lib/oystercard'

card = Oystercard.new

card.top_up(40)
puts card.balance
puts card.journeys
card.touch_in("Kensington")

puts card.in_journey
#expecting to not get an error
card.touch_out("Picadilly")

puts card.in_journey
puts card.balance
puts card.journeys

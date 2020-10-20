# feature test to make sure that touch_in ccepts and stores station
# travelled from
require_relative '../lib/oystercard'

card = Oystercard.new

card.top_up(40)
puts card.balance
#expecting to not get an error
card.touch_in("Kensington")

puts card.in_journey

card.touch_out

puts card.in_journey
puts card.balance

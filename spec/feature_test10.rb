# feature test to make sure that touch_out reduces the balnace
require_relative '../lib/oystercard'

card = Oystercard.new

card.top_up(40)
puts card.balance
card.touch_out
# expecting to get the balance reduced by minimal fare charge
puts card.balance

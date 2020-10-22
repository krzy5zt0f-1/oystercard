require_relative 'station'
require_relative 'journey'
class Oystercard
  attr_reader :balance, :journeys
  @@default_min_cap = 1
  @@default_max_cap = 90
  def initialize(balance = 0)
    @balance = balance
    @current_journey
    @journeys = []
  end

  def top_up(amount)
    fail "Can't exceed limit of £90" if (@balance + amount) > @@default_max_cap
    @balance += amount
  end

  def touch_in(station_instance)
    fail "Not enough credit, TOP UP!" if @balance < @@default_min_cap
    @current_journey = Journey.new
    @current_journey.start(station_instance)

  end

  def touch_out(station_instance)
    @current_journey.end(station_instance)
    @journeys << [@current_journey.entry_station, @current_journey.end_station]
    @balance -= @current_journey.fare
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end

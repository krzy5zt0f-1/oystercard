require_relative 'journeylog'
class Oystercard
  attr_reader :balance
  @@default_min_cap = 1
  @@default_max_cap = 90

  def initialize
    @journey_log = JourneyLog.new(journey_class: Journey)
    @balance = 0
  end

  def top_up(amount)
    fail "Can't exceed limit of £90" if (@balance + amount) > @@default_max_cap
    @balance += amount
  end

  def touch_in(station_instance)
    fail "Not enough credit, TOP UP!" if @balance < @@default_min_cap
    @journey_log.start(station_instance)
  end

  def touch_out(station_instance)

    @journey_log.finish(station_instance)
    @balance -= last_journey.fare
  end
  private

  def last_journey
    @journey_log.journeys[-1]
  end

end

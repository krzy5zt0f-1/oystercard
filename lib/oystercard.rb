class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :journeys
  @@default_min_fare_charge = 2.50

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @default_min_cap = 1
    @default_max_cap = 90
    @entry_station
    @journeys = []
  end

  def top_up(amount)
    fail "Can't exceed limit of £90" if (@balance + amount) > @default_max_cap
    @balance += amount
  end

  def touch_in(station)
    fail "Not enough credit, TOP UP!" if @balance < @default_min_cap
    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    @journeys << {entry: @entry_station, exit: station}
    @entry_station = nil
    @balance -= @@default_min_fare_charge
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end

class Oystercard
  attr_reader :balance, :in_journey
  @@default_min_fare_charge = 2.50
  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @default_min_cap = 1
    @default_max_cap = 90
  end

  def top_up(amount)
    fail "Can't exceed limit of £90" if (@balance + amount) > @default_max_cap
    @balance += amount
  end

  def touch_in
    fail "Not enough credit, TOP UP!" if @balance < @default_min_cap
    @in_journey = true
  end

  def touch_out
    @balance -= @@default_min_fare_charge
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end

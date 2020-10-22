require_relative 'station'

# instance of journey class is `short lived`, i.e. each istance only describes
# one journey
class Journey
  @@PENALTY_FARE = 6
  @@default_min_fare_charge = 2.50
  attr_reader :entry_station, :end_station

  def initialize
    @entry_station; @end_station
  end

  def start(station_instance)
    @entry_station = {name: station_instance.name, zone: station_instance.zone}
  end

  def end(station_instance)
    @end_station = {name: station_instance.name, zone: station_instance.zone}
  end

  def fare
    if (!complete || @entry_station == nil)
      @@PENALTY_FARE
    else
    multiplyer = (@end_station[:zone] - @entry_station[:zone]).abs
    multiplyer == 0 ? @@default_min_fare_charge : (multiplyer + 1) * @@default_min_fare_charge
    end
  end

  def complete
    @end_station != nil
  end
end

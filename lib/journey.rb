require_relative 'station'
class Journey
  attr_reader :in_journey, :entry_station, :end_station, :journeys

  def initialize
    @in_journey = false
    @entry_station; @end_station
    @journeys = []
  end

  def start(station_instance)
    @entry_station = {name: station_instance.name, zone: station_instance.zone}
    @in_journey = true
  end

  def end(station_instance)
    @end_station = {name: station_instance.name, zone: station_instance.zone}
    @in_journey = false; @journeys << [@entry_station, @end_station]
  end
end

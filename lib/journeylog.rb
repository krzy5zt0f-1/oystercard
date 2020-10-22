require_relative  '../lib/journey'

class JourneyLog
  def initialize(journey_class:)
    @journey_class = journey_class
    @journeys = []
  end
  def start(station_instance)
    current_journey
    @current_journey.begin(station_instance)
    @journeys << @current_journey
  end

  def finish(station_instance)
    current_journey
    @current_journey.end(station_instance)
    @journeys << @current_journey
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end
private
  def current_journey
    @current_journey ||= @journey_class.new
  end
end

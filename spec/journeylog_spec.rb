require_relative '../lib/journeylog'

describe JourneyLog do
  let(:journey) {double :journey}
  let(:station) {double :station}
  let(:station1) {double :station1}
  let(:journey_class_double) {double :journey_class, new: journey}
  subject {described_class.new(journey_class: journey_class_double)}

  describe "#start" do
    it "starts a journey" do
      expect(journey).to receive(:begin).with(station)
      subject.start(station)
    end
    it "records a journey" do
      allow(journey).to receive(:begin).and_return(station)
      subject.start(station)
      expect(subject.journeys).to include journey
    end
    it "starts a journey after an incomplete one" do
      allow(journey).to receive(:begin).and_return(station)
      subject.start(station)
      expect(journey).to receive(:begin).with(station1)
      subject.start(station1)
    end
  end
  describe "#finish" do
    it "adds finish station, provided the starting one was given" do
      allow(journey).to receive(:begin).and_return(station)
      subject.start(station)
      expect(journey).to receive(:end).with(station)
      subject.finish(station)
    end
    it "adds finish station, provided the starting one was not given" do
      expect(journey).to receive(:end).with(station)
      subject.finish(station)
    end
    it "updates the finish station in journeys" do
      allow(journey).to receive(:begin).and_return(station)
      allow(journey).to receive(:end).and_return(station1)
      subject.start(station)
      subject.finish(station1)
      expect(subject.journeys).to include journey
    end
    it "updates the finish station in journeys even if no entry was given" do
      allow(journey).to receive(:begin).and_return(station)
      allow(journey).to receive(:end).and_return(station1)
      #subject.start(station)
      subject.finish(station1)
      expect(subject.journeys).to include journey
    end
    it "updates the @current_journey to be nil" do
      allow(journey).to receive(:begin).and_return(station)
      allow(journey).to receive(:end).and_return(station1)
      subject.start(station)
      expect(subject.finish(station1)).to eq nil
    end
  end

end

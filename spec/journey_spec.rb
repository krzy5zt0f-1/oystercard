require_relative '../lib/journey'

describe Journey do
  let(:station) { double :station }
  let(:station1) { double :station1 }
  it { is_expected.to respond_to(:begin) }
  it { is_expected.to respond_to(:end) }
  it { is_expected.to respond_to(:entry_station) }
  it { is_expected.to respond_to(:end_station) }
  it { is_expected.to respond_to(:fare) }
  it { is_expected.to respond_to(:complete) }

  describe "#begin" do
    it "saves entry station" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.begin(station)
      expect(subject.entry_station).to eq ({:name=>"station", :zone=>1})
    end
  end
  describe "#end" do
    it "saves end station" do
      allow(station).to receive(:name).and_return("station1")
      allow(station).to receive(:zone).and_return(2)
      subject.end(station)
      expect(subject.end_station).to eq ({:name=>"station1", :zone=>2})
    end
  end
  describe ".complete" do
    it "by default journey is not complete" do
      expect(subject.complete).to eq (false)
    end
    it "it knows if the journey is no complete" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.begin(station)
      expect(subject.complete).to eq (false)
    end
    it "it knows when the journey is complete" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.end(station)
      expect(subject.complete).to eq (true)
    end
  end
  describe ".fare" do
    it "returns penalty by default" do
      expect(subject.fare).to eq Journey.class_variable_get(:@@PENALTY_FARE)
    end
    it "returns penalty when no entry station given" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.end(station)
      expect(subject.fare).to eq Journey.class_variable_get(:@@PENALTY_FARE)
    end
    it " calculates ocrrect fare if traveling within same zone" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.begin(station)
      subject.end(station)
      expect( subject.fare).to eq Journey.class_variable_get(:@@default_min_fare_charge)
    end
    it " calculates correct fare if traveling between zones" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.begin(station)
      allow(station1).to receive(:name).and_return("station1")
      allow(station1).to receive(:zone).and_return(3)
      subject.end(station1)
      expect( subject.fare).to eq 3 * Journey.class_variable_get(:@@default_min_fare_charge)
    end
  end
end

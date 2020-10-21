require_relative '../lib/journey'

describe Journey do
  let(:station) { double :station }
  it { is_expected.to respond_to(:in_journey) }
  it { is_expected.to respond_to(:start) }
  it { is_expected.to respond_to(:end) }
  it { is_expected.to respond_to(:entry_station) }

  describe "#start" do
    it "saves entry station" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      subject.start(station)
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

end

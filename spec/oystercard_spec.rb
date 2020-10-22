require 'oystercard'
describe Oystercard do
  let(:station) { double :station }
  let(:station1) { double :station1 }
  it { is_expected.to respond_to(:balance) }
  it { is_expected.to respond_to(:top_up) }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }
  it { is_expected.to respond_to(:journeys) }
  describe ".journeys" do
    it "has an empty array by default" do
      expect(subject.journeys).to eq []
    end
    it "stores travelled journeys" do
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      allow(station1).to receive(:name).and_return("station1")
      allow(station1).to receive(:zone).and_return(3)
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station1)
      expect(subject.journeys).to eq [[{:name=>"station", :zone=>1}, {:name=>"station1", :zone=>3}]]
    end
  end
  describe '.balance' do
    it 'returns the balance of the card' do
      expect(subject.balance).to eq 0
    end
  end
  describe "#top_up()" do
    it "adds balance to the card" do
      expect(subject.top_up(5)).to eq 5
    end
    it "edge case for max top up allowed" do
      expect(subject.top_up(90)).to eq 90
    end

    it 'throws an error when trying to exceed £90' do
      expect { subject.top_up(91) }.to raise_error("Can't exceed limit of £90")
    end
  end
  describe '.touch_in' do
    it "throws an error if balance has insufficent funds" do
      expect { subject.touch_in(station) }.to raise_error "Not enough credit, TOP UP!"
    end
    it "throws an error if no station provided" do
      expect { subject.touch_in }.to raise_error(ArgumentError)
    end
  end
  describe '.touch_out' do
    it "charges minimal fare charge for travel in same zone" do
      subject.top_up(40)
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      allow(station1).to receive(:name).and_return("station1")
      allow(station1).to receive(:zone).and_return(1)
      subject.touch_in(station)
      expect{subject.touch_out(station1)}.to change{subject.balance}.by (-2.5)
    end
    it "throws an error if no station provided" do
      expect { subject.touch_out }.to raise_error(ArgumentError)
    end
    it "charges specific fare charge for travel across zones" do
      subject.top_up(40)
      allow(station).to receive(:name).and_return("station")
      allow(station).to receive(:zone).and_return(1)
      allow(station1).to receive(:name).and_return("station1")
      allow(station1).to receive(:zone).and_return(3)
      subject.touch_in(station)
      expect{subject.touch_out(station1)}.to change{subject.balance}.by (-7.5)
    end
    it "it charges penalty if no  entry given" do
      subject.top_up(40)
      allow(station1).to receive(:name).and_return("station1")
      allow(station1).to receive(:zone).and_return(3)
      expect{subject.touch_out(station1)}.to change{subject.balance}.by (-6)
    end
  end
end

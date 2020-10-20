require 'oystercard'
describe Oystercard do
  let(:station) { double :station }
  it { is_expected.to respond_to(:balance) }
  it { is_expected.to respond_to(:top_up) }
  it { is_expected.to respond_to(:in_journey) }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

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
    it 'changes in_journey to be true' do
      allow(station).to receive(:length).and_return(1)
      subject.top_up(5)
      expect(subject.touch_in(station)).to eq true
      expect(subject.entry_station).to eq station
    end
    it "throws an error if balance has insufficent funds" do
      expect { subject.touch_in(station) }.to raise_error "Not enough credit, TOP UP!"
    end
    it "throws an error if no station provided" do
      expect { subject.touch_in }.to raise_error(ArgumentError)
    end
  end
  describe '.touch_out' do
    it 'changes in_journey to be false' do
      allow(station).to receive(:length).and_return(1)
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.touch_out).to eq false
    end
    it 'changes entry_station to be nil' do
      allow(station).to receive(:length).and_return(1)
      subject.top_up(5)
      subject.touch_in(station)
      expect{subject.touch_out}.to change{subject.entry_station}.to (nil)
    end
    it "charges minimal fare charge once touched out" do
      subject.top_up(40)
      expect{subject.touch_out}.to change{subject.balance}.by (-2.5)
    end
  end

end

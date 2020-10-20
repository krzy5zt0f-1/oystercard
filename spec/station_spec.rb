require 'station'

describe Station do
    subject {described_class.new("Kensington", 2)}

  it "creates a station name" do
    expect(subject.name).to eq "Kensington"
  end
  it "creates a zone type" do
    expect(subject.zone).to eq 2
  end
end

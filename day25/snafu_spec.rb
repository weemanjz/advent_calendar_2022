require "rspec"
require_relative "snafu"

RSpec.describe Snafu do
  describe "#to_i" do
    it { expect(described_class.new("0").to_i).to eq(0) }
    it { expect(described_class.new("1").to_i).to eq(1) }
    it { expect(described_class.new("2").to_i).to eq(2) }
    it { expect(described_class.new("1=").to_i).to eq(3) }
    it { expect(described_class.new("1-").to_i).to eq(4) }
    it { expect(described_class.new("10").to_i).to eq(5) }
    it { expect(described_class.new("1=-0-2").to_i).to eq(1747) }
    it { expect(described_class.new("12111").to_i).to eq(906) }
  end

  describe "#parse" do
    it { expect(described_class.parse(0)).to eq(Snafu.new("0")) }
    it { expect(described_class.parse(1)).to eq(Snafu.new("1")) }
    it { expect(described_class.parse(2)).to eq(Snafu.new("2")) }
    it { expect(described_class.parse(3)).to eq(Snafu.new("1=")) }
    it { expect(described_class.parse(4)).to eq(Snafu.new("1-")) }
    it { expect(described_class.parse(5)).to eq(Snafu.new("10")) }
    it { expect(described_class.parse(6)).to eq(Snafu.new("11")) }
    it { expect(described_class.parse(7)).to eq(Snafu.new("12")) }
    it { expect(described_class.parse(8)).to eq(Snafu.new("2=")) }
    it { expect(described_class.parse(9)).to eq(Snafu.new("2-")) }
    it { expect(described_class.parse(10)).to eq(Snafu.new("20")) }
    it { expect(described_class.parse(15)).to eq(Snafu.new("1=0")) }
    it { expect(described_class.parse(20)).to eq(Snafu.new("1-0")) }
    it { expect(described_class.parse(2022)).to eq(Snafu.new("1=11-2")) }
    it { expect(described_class.parse(4890)).to eq(Snafu.new("2=-1=0")) }
  end

  describe "#+" do
    it "adsd two anfu number" do
      sum = described_class.new("1=-0-2") + described_class.new("12111")
    end
  end
end

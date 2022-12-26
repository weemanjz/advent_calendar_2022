require "rspec"
require_relative "map"

RSpec.describe Map do
  subject(:map) { described_class.new(m) }

  let(:m) do
    [
      "#.######",
      "#>>.<^<#",
      "#.<..<<#",
      "#>v.><>#",
      "#<^v^^>#",
      "######.#"
    ]
  end

  describe "#escape" do
    it { expect(map.escape).to eq(18) }
  end
end

require "rspec"
require_relative "map2"

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
    it { expect(map.escape).to eq(54) }
  end
end

defmodule VesselMatchTest do
  use ExUnit.Case

  test "state_name" do
    vessel = VesselMatch.new()
    assert :empty == VesselMatch.state(vessel)
  end

  test "fill" do
    vessel = VesselMatch.new()
    vessel = VesselMatch.fill(vessel)
    assert :full == VesselMatch.state(vessel)
  end

  test "pour a lot" do
    vessel = VesselMatch.new()
    add_quantity = 1000
    vessel = VesselMatch.pour(vessel, add_quantity)
    assert add_quantity == vessel.amount_in_cc
    assert :full == VesselMatch.state(vessel)
  end
  
  test "pour a little" do
    vessel = VesselMatch.new()
    add_quantity = 10
    vessel = VesselMatch.pour(vessel, add_quantity)
    assert add_quantity == vessel.amount_in_cc
    assert :half_full == VesselMatch.state(vessel)
  end

  test "pour a little then the rest" do
    vessel = VesselMatch.new()
    add_quantity = 50
    vessel = VesselMatch.pour(vessel, add_quantity)
    vessel = VesselMatch.pour(vessel, add_quantity)
    assert :full == VesselMatch.state(vessel)
  end

  test "fill and heat" do
    vessel = VesselMatch.new()
    vessel = VesselMatch.fill(vessel)
    vessel = VesselMatch.heat(vessel)
    assert :full == VesselMatch.state(vessel)
  end

  test "heat empty, crack" do
    vessel = VesselMatch.new()
    vessel = VesselMatch.heat(vessel)
    assert :cracked == VesselMatch.state(vessel)
  end
end

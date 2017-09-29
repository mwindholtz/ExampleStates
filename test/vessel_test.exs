defmodule VesselTest do
  use ExUnit.Case

  test "start_link" do
    pid = Vessel.start_link()
    assert is_pid(pid)
  end

  test "fill" do
    pid = Vessel.start_link()
    Vessel.fill(pid)
    assert :full == Vessel.state(pid)
  end

  test "state_name" do
    pid = Vessel.start_link()
    assert :empty == Vessel.state(pid)
  end

  test "pour a lot" do
    pid = Vessel.start_link()
    add_quantity = 1000
    result = Vessel.pour(pid, add_quantity)
    assert result == %Vessel{amount_in_cc: add_quantity}
    assert :full == Vessel.state(pid)
  end
  
  test "pour a little" do
    pid = Vessel.start_link()
    add_quantity = 10
    result = Vessel.pour(pid, add_quantity)
    assert result == %Vessel{amount_in_cc: add_quantity}
    assert :half_full == Vessel.state(pid)
  end

  test "pour a little then the rest" do
    pid = Vessel.start_link()
    add_quantity = 50
    Vessel.pour(pid, add_quantity)
    Vessel.pour(pid, add_quantity)
    assert :full == Vessel.state(pid)
  end

end

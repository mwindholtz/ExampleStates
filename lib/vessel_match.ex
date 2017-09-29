defmodule VesselMatch do
  defstruct state: :empty, amount_in_cc: 0, capacity: 100
  
  def new, do: %VesselMatch{}

  def state(vessel) do
    vessel.state
  end

  def fill(vessel) do
    %{ vessel | state: :full }
  end

  def pour(vessel, amount_in_cc) do
    with mod_amount <- (vessel.amount_in_cc + amount_in_cc),
         is_full    <- (mod_amount >= vessel.capacity )
    do  
      next_state = if is_full do   :full
                              else :half_full
                              end
      %{ vessel | state: next_state, amount_in_cc: amount_in_cc }
    end
  end

  def heat(vessel = %VesselMatch{state: :full}) do
    vessel
  end

  def heat(vessel = %VesselMatch{state: :empty}) do
    %{ vessel | state: :cracked }
  end

end

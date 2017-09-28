defmodule Vessel do
  defstruct amount_in_cc: 0, capacity: 100

  use GenStateMachine
  
  def new, do: %Vessel{}

  def start_link do
    {:ok, pid} = GenStateMachine.start_link(__MODULE__, {:empty, Vessel.new()})
    pid
  end

  def state(pid) do
    GenStateMachine.call(pid, :get_state_name)
  end

  def pour(pid, amount_in_cc) do
    GenStateMachine.call(pid, {:pour, amount_in_cc})
  end

  def fill(pid) do
    GenStateMachine.call(pid, :fill)
  end

  def handle_event({:call, from}, :get_state_name, state_name, _vessel) do
    GenStateMachine.reply(from, state_name)
    :keep_state_and_data
  end

  def handle_event({:call, from}, :fill, state_name, vessel) do
    vessel = %{ vessel | amount_in_cc: vessel.capacity }
    {:next_state, :full, vessel, [{:reply, from, vessel}]}
  end

  def handle_event({:call, from}, {:pour, amount_in_cc}, state_name, vessel) do
    with mod_amount <- (vessel.amount_in_cc + amount_in_cc),
         vessel     <- %{ vessel | amount_in_cc: mod_amount },
         is_full    <- vessel.amount_in_cc >= vessel.capacity
    do
      next_state = if is_full do   :full
                              else :half_full
                              end
      {:next_state, next_state, vessel, [{:reply, from, vessel}]}
    end
  end
   
end
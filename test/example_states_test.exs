defmodule ExampleStatesTest do
  use ExUnit.Case
  doctest ExampleStates

  test "greets the world" do
    assert ExampleStates.hello() == :world
  end
end

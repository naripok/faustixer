defmodule FaustixerTest do
  use ExUnit.Case
  doctest Faustixer

  test "greets the world" do
    assert Faustixer.hello() == :world
  end
end

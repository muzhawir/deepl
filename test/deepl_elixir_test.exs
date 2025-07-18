defmodule DeeplElixirTest do
  use ExUnit.Case
  doctest DeeplElixir

  test "greets the world" do
    assert DeeplElixir.hello() == :world
  end
end

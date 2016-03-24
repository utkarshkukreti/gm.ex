defmodule GmTest do
  use ExUnit.Case
  doctest Gm

  test "open/1" do
    assert Gm.open("test.jpg") == %Gm.Command{args: ["test.jpg"]}
  end
end

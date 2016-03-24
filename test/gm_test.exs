defmodule GmTest do
  use ExUnit.Case
  doctest Gm

  test "open/1" do
    assert Gm.open("test.jpg") == %Gm.Command{args: ["test.jpg"]}
  end

  test "write/2" do
    assert :ok = Gm.open("xc:red") |> Gm.write("_build/test.jpg")

    assert {:error, error} = Gm.open("test.jpg") |> Gm.write("_build/test.jpg")
    assert error =~ "Unable to open file"
    assert error =~ "test.jpg"
  end
end

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

  test "resize/3" do
    assert Gm.open("xc:red") |> Gm.resize(100, 100) ==
           %Gm.Command{args: ["xc:red", "-resize", "100x100"]}
  end

  test "font/2" do
    assert Gm.open("xc:red") |> Gm.font("test.ttf") ==
           %Gm.Command{args: ["xc:red", "-font", "test.ttf"]}
  end

  test "draw_text/4" do
    assert Gm.open("xc:red") |> Gm.draw_text(0, 0, ~S|a'"|) ==
           %Gm.Command{args: ["xc:red", "-draw", ~S|text 0,0 "a'\""|]}
  end

  test "fill/2" do
    assert Gm.open("xc:red") |> Gm.fill("green") ==
           %Gm.Command{args: ["xc:red", "-fill", "green"]}
  end

  test "point_size/2" do
    assert Gm.open("xc:red") |> Gm.point_size(36) ==
           %Gm.Command{args: ["xc:red", "-pointsize", "36"]}
  end
end

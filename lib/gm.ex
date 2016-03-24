defmodule Gm do
  defmodule Command do
    defstruct args: []
  end

  def open(path) when is_binary(path) do
    %Command{args: [path]}
  end

  def write(%Command{args: args}, path) when is_binary(path) do
    command = "gm"
    args = ["convert" | args ++ [path]]
    opts = [stderr_to_stdout: true]
    case System.cmd(command, args, opts) do
      {_, 0}     -> :ok
      {error, _} -> {:error, error}
    end
  end

  def resize(%Command{args: args} = command, width, height)
      when is_integer(width) and is_integer(height) do
    %{command | args: args ++ ["-resize", "#{width}x#{height}"]}
  end

  def font(%Command{args: args} = command, font) when is_binary(font) do
    %{command | args: args ++ ["-font", font]}
  end

  def draw_text(%Command{args: args} = command, x0, y0, string)
      when is_integer(x0) and is_integer(y0) and is_binary(string) do
    string = String.replace(string, ~S|"|, ~S|\"|)
    %{command | args: args ++ ["-draw", ~s|text #{x0},#{y0} "#{string}"|]}
  end

  def fill(%Command{args: args} = command, color) when is_binary(color) do
    %{command | args: args ++ ["-fill", color]}
  end

  def point_size(%Command{args: args} = command, size) when is_integer(size) do
    %{command | args: args ++ ["-pointsize", "#{size}"]}
  end

  @operators [:over] # TODO: Add more.
  def draw_image(%Command{args: args} = command, operator, x0, y0, w, h, path)
      when operator in @operators and is_integer(x0) and is_integer(y0) and
           is_integer(w) and is_integer(h) and is_binary(path) do
    path = String.replace(path, ~S|"|, ~S|\"|)
    %{command | args: args ++ ["-draw", ~s|image #{operator} #{x0},#{y0} #{w},#{h} "#{path}"|]}
  end
end

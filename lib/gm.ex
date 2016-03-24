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
end

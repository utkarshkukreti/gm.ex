# Gm

Idiomatic [GraphicsMagick](http://www.graphicsmagick.org) wrapper for Elixir.

## Prerequisites

Make sure you have [GraphicsMagick](http://www.graphicsmagick.org) installed on
your system.

* On Mac OS X: `brew install graphicsmagick`
* On Arch Linux: `pacman -S graphicsmagick`
* On Ubuntu: `apt-get install graphicsmagick`

## Installation

Add gm to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:gm, "~> 0.0.1"}]
end
```

and run `mix deps.get`.

## Usage

### Creating a thumbnail

```elixir
Gm.open("large.jpg")
|> Gm.resize(100, 100)
|> Gm.write("thumbnail.jpg") # => :ok
```

### Writing text over an image

```elixir
Gm.open("image.jpg")
|> Gm.font("Fira-Sans.ttf")
|> Gm.point_size(24)
|> Gm.fill("red")
|> Gm.draw_text(400, 100, "This is a caption")
|> Gm.write("captioned.jpg") # => :ok
```

More examples coming soon.

## License

MIT

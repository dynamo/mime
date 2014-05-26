defmodule MIME.Mixfile do
  use Mix.Project

  @version String.strip(File.read!("VERSION"))

  def project do
    [ app: :mime,
      version: @version,
      elixir: "~> 0.13.0 or ~> 0.14.0-dev" ]
  end
end

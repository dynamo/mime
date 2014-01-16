defmodule MIME.Mixfile do
  use Mix.Project

  @version String.strip(File.read!("VERSION"))

  def project do
    [ app: :mime,
      version: @version,
      elixir: "~> 0.12.2" ]
  end
end

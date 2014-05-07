defmodule MIME.Types do
  @moduledoc """
  Maps MIME types to file extensions and vice versa.
  """

  @default_type "application/octet-stream"

  stream = File.stream! Path.expand("../../priv/mime.types", __DIR__)
  mapping = Enum.reverse Enum.reduce(stream, [], fn (line, acc) ->
    if String.match?(line, ~r/^[#\n]/) do
      acc
    else
      [ type | exts ] = String.split(String.strip(line))
      [ { type, exts } | acc ]
    end
  end)

  @doc """
  Returns whether a MIME type is registered.

  iex> MIME.Types.valid?("text/plain")
  true
  """

  @spec valid?(String.t) :: boolean
  def valid?(type) do
    is_list entry(type)
  end

  @doc """
  Returns the extensions associated with a MIME type.

  iex> MIME.Types.extensions("text/html")
  ["html", "htm"]
  """

  @spec extensions(String.t) :: [String.t]
  def extensions(type) do
    entry(type) || []
  end

  @doc """
  Returns the MIME type associated with a file extension.

  iex> MIME.Types.type("txt")
  "text/plain"
  """

  @spec type(String.t) :: String.t

  for { type, exts } <- mapping do
    for ext <- exts do
      def type(unquote(ext)), do: unquote(type)
    end
  end

  def type(_ext), do: @default_type

  @doc """
  Guesses the MIME type based on the path's extension.

  iex> MIME.Types.path("index.html")
  "text/html"
  """

  @spec path(Path.r) :: String.t
  def path(path) do
    case Path.extname(path) do
      "." <> ext -> type(ext)
      _ -> @default_type
    end
  end

  # entry/1

  for { type, exts } <- mapping do
    defp entry(unquote(type)), do: unquote(exts)
  end

  defp entry(_type), do: nil
end

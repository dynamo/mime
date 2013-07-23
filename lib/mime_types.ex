defmodule MIMETypes do
  @moduledoc """
  Maps MIME types to file extensions and vice versa.
  """

  @default_type "application/octet-stream"

  data = File.read! Path.expand("../priv/mime.types", __DIR__)

  mapping = Enum.reduce(String.split(data, %r/\n/), [], fn (line, acc) ->
    if line == "" or line =~ %r/^#/ do
      acc
    else
      [ type | exts ] = String.split(line)
      [ { type, exts } | acc ]
    end
  end) |> Enum.reverse

  @doc """
  Returns the extensions associated with a MIME type.

  iex> MIMETypes.extensions("text/plain")
  ["txt", "text", "conf", "def", "list", "log", "in"]
  """

  @spec extensions(String.t) :: [String.t]

  lc { type, exts } inlist mapping do
    def extensions(unquote(type)), do: unquote(exts)
  end

  def extensions(_mimetype), do: []

  @doc """
  Returns the MIME type associated with a file extension.

  iex> MIMETypes.type("txt")
  "text/plain"
  """

  @spec type(String.t) :: String.t

  lc { type, exts } inlist mapping do
    lc ext inlist exts do
      def type(unquote(ext)), do: unquote(type)
    end
  end

  def type(_ext), do: @default_type
end

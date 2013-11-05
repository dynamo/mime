defmodule MIMETypes do
  @moduledoc """
  Maps MIME types to file extensions and vice versa.
  """

  @default_type "application/octet-stream"

  stream = File.stream! Path.expand("../priv/mime.types", __DIR__)
  mapping = Enum.reduce(stream, [], fn (line, acc) ->
    if line =~ %r/^[#\n]/ do
      acc
    else
      [ type | exts ] = String.split(String.strip(line))
      [ { type, exts } | acc ]
    end
  end) |> Enum.reverse

  @doc """
  Returns whether a MIME type is registered.

  iex> MIMETypes.valid?("text/plain")
  true
  """

  @spec valid?(String.t) :: boolean

  lc { type, _exts } inlist mapping do
    def valid?(unquote(type)), do: true
  end

  def valid?(_type), do: false

  @doc """
  Returns the extensions associated with a MIME type.

  iex> hd MIMETypes.extensions("text/plain")
  "txt"
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

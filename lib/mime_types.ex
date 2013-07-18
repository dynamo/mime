defmodule MIMETypes do
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

  @spec extensions(String.t) :: [String.t]

  lc { type, exts } inlist mapping do
    def extensions(unquote(type)), do: unquote(exts)
  end

  def extensions(_mimetype), do: []

  @spec type(String.t) :: String.t

  lc { type, exts } inlist mapping do
    lc ext inlist exts do
      def type(unquote(ext)), do: unquote(type)
    end
  end

  def type(_ext), do: @default_type
end

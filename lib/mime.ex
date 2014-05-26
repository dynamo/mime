defmodule MIME do
  def version do
    unquote(Mix.Project.config[:version])
  end
end

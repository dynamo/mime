Code.require_file "test_helper.exs", __DIR__

defmodule MIMETypesTest do
  use ExUnit.Case, async: true

  import MIMETypes

  doctest MIMETypes

  test :valid? do
    assert valid?("application/json")
    refute valid?("application/prs.joseshrine")
  end

  test :extensions do
    assert "json" in extensions("application/json")
    assert extensions("application/vnd.api+json") == []
  end

  test :type do
    assert type("json") == "application/json"
    assert type("foo") == "application/octet-stream"
  end
end

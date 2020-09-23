defmodule AntlUtilsAbsinthe.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  describe "put_context/2" do
    test "when context does not exists, add it with the provided keys" do
      conn =
        conn(:post, "/")
        |> AntlUtilsAbsinthe.Plug.put_context(key: :value)

      assert conn.private.absinthe.context.key == :value
    end

    test "all provided keys will be added to context" do
      conn =
        conn(:post, "/")
        |> AntlUtilsAbsinthe.Plug.put_context(key_1: :value_1)
        |> AntlUtilsAbsinthe.Plug.put_context(key_2: :value_2)

      assert conn.private.absinthe.context.key_1 == :value_1
      assert conn.private.absinthe.context.key_2 == :value_2
    end

    test "provided keys overrides any existing one in the context" do
      conn =
        conn(:post, "/")
        |> AntlUtilsAbsinthe.Plug.put_context(key_1: :value_1)
        |> AntlUtilsAbsinthe.Plug.put_context(key_1: :new_value_1, key_2: :value_2)

      assert conn.private.absinthe.context.key_1 == :new_value_1
      assert conn.private.absinthe.context.key_2 == :value_2
    end
  end
end

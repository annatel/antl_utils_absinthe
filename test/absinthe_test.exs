defmodule AntlUtilsAbsintheTest do
  use ExUnit.Case

  defmodule Middleware do
    @behaviour Absinthe.Middleware

    @impl true
    @spec call(Absinthe.Resolution.t(), term) :: Absinthe.Resolution.t()
    def call(resolution, _config), do: resolution
  end

  defmodule Schema do
    use Absinthe.Schema

    query name: "my_root_query" do
      field :my_query, :string do
        arg(:my_arg, :string)
        middleware(Middleware)
      end
    end
  end

  describe "lookup_field/3" do
    test "returns the field" do
      assert %Absinthe.Type.Field{identifier: :my_query} =
               AntlUtilsAbsinthe.lookup_field(Schema, "my_root_query", :my_query)
    end

    test "if the field does not exist, returns nil" do
      assert_raise ArgumentError, "field: fake_query not found in my_root_query", fn ->
        AntlUtilsAbsinthe.lookup_field(Schema, "my_root_query", :fake_query)
      end
    end

    test "if the object does not exist, raises an argument_error exception" do
      assert_raise ArgumentError, "object: fake_root_query not found in schema", fn ->
        AntlUtilsAbsinthe.lookup_field(Schema, :fake_root_query, :my_query)
      end
    end
  end

  describe "has_middleware?/2" do
    test "true if the field has the middleware" do
      my_query = AntlUtilsAbsinthe.lookup_field(Schema, "my_root_query", :my_query)
      assert AntlUtilsAbsinthe.has_middleware?(my_query, Middleware)
    end

    test "false if the field does not call the middleware" do
      my_query = AntlUtilsAbsinthe.lookup_field(Schema, "my_root_query", :my_query)
      refute AntlUtilsAbsinthe.has_middleware?(my_query, FakeMiddleware)
    end
  end
end

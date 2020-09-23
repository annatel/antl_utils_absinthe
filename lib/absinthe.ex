defmodule AntlUtilsAbsinthe do
  @moduledoc """
  Helper functions for Absinthe.
  """

  @spec lookup_field(module(), atom(), atom()) :: Absinthe.Type.Field.t() | nil
  def lookup_field(schema, object, field) do
    type = Absinthe.Schema.lookup_type(schema, object)

    if is_nil(type), do: raise(ArgumentError, "object: #{object} not found in schema")

    Map.get(type.fields, field) ||
      raise(ArgumentError, "field: #{field} not found in #{object}")
  end

  @spec has_middleware?(Absinthe.Type.Field.t(), module()) :: boolean()
  def has_middleware?(field, middleware_module) do
    %{middleware: middlewares} = field

    Enum.find(middlewares, &match?({{^middleware_module, :call}, _}, &1))
  end
end

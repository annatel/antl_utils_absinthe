defmodule AntlUtilsAbsinthe.Plug do
  @moduledoc """
  Documentation for AntlAbsinthe.Plug
  """

  @doc """
  Assigns multiple **context** keys and values in the connection.

  ## Examples
      iex> conn.private.absinthe.context[:my_plug_hello]
      nil
      iex> conn = put_context(conn, my_plug_hello: :world)
      iex> conn.private.absinthe.context[:my_plug_hello]
      :world
  """
  @spec put_context(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def put_context(%Plug.Conn{private: %{absinthe: %{context: context}}} = conn, keywords)
      when is_list(keywords) do
    context = Enum.into(keywords, context)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def put_context(conn, keywords) when is_list(keywords) do
    context = Enum.into(keywords, %{})
    Absinthe.Plug.put_options(conn, context: context)
  end
end

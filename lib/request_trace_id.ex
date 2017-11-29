defmodule RequestTraceId do
  @moduledoc """
  A plug for creating unique span-ids on each request. Based on:

  https://github.com/elixir-plug/plug/blob/
  3d48af2b97d58c183a7b8390abc42ac5367b0770/lib/plug/request_id.ex#L1

  The difference being that this plug will append a new span-id to the
  request-trace-id header if there is already a value set instead of only
  passing along the existing request-trace-id.
  """

  require Logger
  alias Plug.Conn

  @behaviour Plug

  @trace_id_header "x-request-trace-id"

  def init([]), do: []

  def call(conn, []) do
    conn
    |> Conn.get_req_header(@trace_id_header)
    |> update_request_trace_id()
    |> set_request_trace_id(conn)
  end

  defp set_request_trace_id(request_trace_id, conn) do
    Logger.metadata(request_id: request_trace_id)
    Conn.put_resp_header(conn, @trace_id_header, request_trace_id)
  end

  @doc """
  Updates the request-trace-id by appending a new span-id or returning just a
  new span-id if the request-trace-id is empty.
  """
  @spec update_request_trace_id([String.t]) :: String.t
  def update_request_trace_id([]) do
    generate_span_id()
  end
  def update_request_trace_id(ids) when is_list(ids) do
    "#{Enum.join(ids, ";")};#{generate_span_id()}"
  end

  @doc """
  Generates a random id to represent the request.
  """
  def generate_span_id do
    Base.hex_encode32(:crypto.strong_rand_bytes(20), case: :lower)
  end
end

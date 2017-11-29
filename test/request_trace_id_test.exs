defmodule RequestTraceIdTest do
  use ExUnit.Case
  use Plug.Test
  doctest RequestTraceId

  defmodule TestPlug do
    use Plug.Builder

    plug RequestTraceId

    plug :index
    defp index(conn, _opts), do: conn |> send_resp(200, "OK")
  end

  test "validate test plug" do
    conn =
      conn(:get, "/")
      |> TestPlug.call([])

    assert conn.status == 200
  end

  test "we receive a custom header with content" do
    conn =
      conn(:get, "/")
      |> TestPlug.call([])

    trace_id =  get_resp_header(conn, "x-request-trace-id")
    assert trace_id != nil
  end

  test "we append to the trace-id if already there" do
    parent_trace_id = "123"
    conn =
      conn(:get, "/")
      |> put_req_header("x-request-trace-id", "123")
      |> TestPlug.call([])

    trace_id =  get_resp_header(conn, "x-request-trace-id")
    span_ids =
      trace_id
      |> List.first()
      |> String.split(";")

    assert trace_id != nil
    assert length(span_ids) == 2
    assert List.first(span_ids) == parent_trace_id
  end
end

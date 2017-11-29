# RequestTraceId

A small plug similar to [`Plug.RequestId`](https://hexdocs.pm/plug/Plug.RequestId.html) except that it appends ids allowing for simple request tracing. Because of this distinction the header used is instead `X-Request-Trace-Id` and the following terminology is adopted (adapted from [Zipkin](zipkin.io)):

**span-id**
* A randomized id generated for each client/server request/response.

**request-trace-id**
* A semicolon delimited string of all span-ids generated during the lifecycle of a single upstream request.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `request_trace_id` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:request_trace_id, "~> 0.1.0"}
  ]
end
```

## Usage

To use it, just plug it into the desired module:

```
plug RequestTraceId
```

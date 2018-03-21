defmodule RequestTraceId.Mixfile do
  use Mix.Project

  def project do
    [
      app: :request_trace_id,
      version: "0.1.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/keyan/request_trace_id",
    ]
  end

  def application do
    [
      extra_applications: [
        :cowboy,
        :logger,
        :plug,
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:plug, "~> 1.4"},
    ]
  end

  defp description do
    "A Plug for request-trace-id generation"
  end

  defp package do
    [
      description: "Plug for request-trace-id generation",
      contributors: ["Keyan Pishdadian"],
      maintainers: ["Keyan Pishdadian"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/keyan/request_trace_id"},
      files: ["lib", "mix.exs", "README.md"],
    ]
  end
end

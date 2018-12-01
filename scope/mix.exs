defmodule Scope.MixProject do
  use Mix.Project

  def project do
    [
      app: :scope,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:phoenix_pubsub],
      extra_applications: [:logger],
      mod: {Scope.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_pubsub, "~> 1.0"}
    ]
  end
end

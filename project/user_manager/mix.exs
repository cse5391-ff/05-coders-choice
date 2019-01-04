defmodule UserManager.MixProject do
  use Mix.Project

  def project do
    [
      app: :user_manager,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {UserManager.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:MapSetStore, path: "../map_set_store", app: false},
      {:IdGenerator, path: "../id_generator", app: false},
    ]
  end
end

defmodule AocElixir.Mixfile do
  use Mix.Project

  def project do
    [
      app: :aoc_elixir,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:advent_of_code_helper, "~> 0.1.0"},
      {:espec, "~> 1.4.6", only: :test},
    ]
  end
end

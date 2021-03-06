defmodule AdventOfCode2020.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2020,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
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
      {:benchee, "~> 1.0"},
      {:flow, "~> 1.0"},
      {:libgraph, "~> 0.7"},
      {:math, "~> 0.5.0"}
    ]
  end
end

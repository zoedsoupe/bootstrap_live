defmodule BootstrapLive.MixProject do
  use Mix.Project

  @source_url "https://github.com/zoedsoupe/bootstrap_live"

  def project do
    [
      app: :bootstrap_live,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:jason, "~> 1.0"},
      {:phoenix, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_view, "~> 0.19"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["WTFPL"],
      links: %{"GitHub" => @source_url},
      files: ~w(lib mix.exs LICENSE README.md)
    ]
  end

  defp aliases do
    [dev: "run --no-halt dev.exs"]
  end
end

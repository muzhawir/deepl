defmodule Deepl.MixProject do
  use Mix.Project

  def project do
    [
      app: :deepl,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "deepl",
      source_url: "https://github.com/muzhawir/deepl",
      homepage_url: "https://hex.pm/packages/deepl",
      docs: &docs/0
    ]
  end

  defp description do
    "Elixir package for the DeepL language translation API."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/muzhawir/deepl"}
    ]
  end

  defp docs do
    [
      main: "getting-started",
      # logo: "priv/assets/logo/doc_logo.svg",
      extras: extra_pages()
    ]
  end

  defp extra_pages do
    List.flatten([
      Path.wildcard("lib/pages/**/*.md")
    ])
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
      # Core
      {:req, "~> 0.5.0"},

      # Documentation
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},

      # Development & testing
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mox, "~> 1.0", only: :test},
      {:styler, "~> 1.2", only: [:dev, :test], runtime: false}
    ]
  end
end

defmodule AntlUtilsAbsinthe.MixProject do
  use Mix.Project

  def project do
    [
      app: :antl_utils_absinthe,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:absinthe_plug, "~> 1.4.7"}
    ]
  end

  defp description() do
    "Absinthe utils."
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/annatel/antl_utils_absinthe"}
    ]
  end
end

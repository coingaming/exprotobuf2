defmodule ExProtobuf.Mixfile do
  use Mix.Project
  
  @version (case File.read("VERSION") do
    {:ok, version} -> String.trim(version)
    {:error, _} -> "0.0.0-development"
  end)
  
  def project do
    [
      app: :exprotobuf,
      version: @version,
      elixir: "~> 1.2",
      elixirc_paths: elixirc_paths(Mix.env),
      description: description(),
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      consolidate_protocols: Mix.env == :prod,
      deps: deps(),
      # docs
      name: "Bennu",
      source_url: "https://github.com/coingaming/exprotobuf2",
      homepage_url: "https://github.com/coingaming/exprotobuf2/tree/v#{@version}",
      docs: [
        source_ref: "v#{@version}"
      ]
    ]
  end

  def application do
    [applications: [:gpb]]
  end

  defp description do
    """
    exprotobuf provides native encoding/decoding of
    protobuf messages via generated modules/structs.
    """
  end

  defp package do
    [ organization: "coingaming",
      files: ["lib", "mix.exs", "README.md", "LICENSE", "VERSION"],
      maintainers: ["Paul Schoenfelder", "Ilja Tkachuk aka timCF"],
      licenses: ["Apache Version 2.0"],
      links: %{"GitHub": "https://github.com/coingaming/exprotobuf2/tree/v#{@version}"} ]
  end

  defp deps do
    [
      {:gpb, "~> 3.24"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:benchfella, "~> 0.3.0", only: [:dev, :test], runtime: false}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "bench/support"]
  defp elixirc_paths(:dev),  do: ["lib", "bench/support"]
  defp elixirc_paths(_),     do: ["lib"]

end

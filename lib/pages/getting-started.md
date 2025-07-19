# Getting Started

[![Hex.pm](https://img.shields.io/hexpm/v/deepl)](https://hex.pm/packages/deepl)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/deepl)](https://hex.pm/packages/deepl)

The [DeepL API](https://www.deepl.com/docs-api) provides a way for programs to send texts and
documents to DeepL's servers and receive high-quality translations and text improvements. This
enables developers to build a wide range of translation tools using DeepL's leading translation technology.

The `deepl` Elixir package is a **community-maintained** library that makes it easy for Elixir applications to work with the DeepL API.

## Requirements

To use `deepl`, your environment must meet these requirements:

- **Erlang**: Version `27.0` or later
- **Elixir**: Version `1.18.0-otp-27` or later

## Installation

Add `deepl` to the dependencies in your `mix.exs` file:

```elixir
def deps do
  [
    {:deepl, "~> 0.0.1"}
  ]
end
```

Fetch the dependencies by running:

```sh
mix deps.get
```

## Authentication

To use the API, you need an authentication key. You can find your key in the
[API Keys section](https://www.deepl.com/en/your-account/keys) of your DeepL account, you
can consume up to 500,000 characters per month for free.

Set the key in your config:

```elixir
# config/config.exs
config :deepl, api_key: "your-api-key"
```

Alternatively, set it at runtime:

```elixir
iex> Deepl.set_api_key("your-api-key")
:ok
```

## Usage

Translate a text:

```elixir
Deepl.translate(
  "Hello, world!",
  [
    split_sentences: 1,
    preserve_formatting: false,
    formality: :default,
    outline_detection: true,
    source_lang: "EN",
    target_lang: "ID"
  ]
)

{
  :ok,
  %{
    "translations" => [
      %{
        "detected_source_language" => "EN",
        "text" => "Elixir luar biasa, DeepL adalah penerjemah yang hebat!"
      }
    ]
  }
}
```

## License

This package is licensed under the [MIT License](https://github.com/muzhawir/deepl/blob/main/LICENSE.md).

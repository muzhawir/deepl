# DeepL

> [!WARNING]
> This package is in active development and considered alpha. APIs and features may change without notice.

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

To install `deepl`, follow the instructions in the
[Getting Started Guide](https://hexdocs.pm/deepl/getting-started.html).

<!-- ## Installation

Add to your `mix.exs`:

```elixir
def deps do
  [
    {:deepl, "~> 0.1.0"}
  ]
end
```

Then fetch dependencies:

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
Deepl.set_api_key("your-api-key")
```

## Usage

Translate a text:

```elixir
iex> Deepl.translate("Hello, world!", target_lang: "DE")
{:ok, %{"translations" => [%{"text" => "Hallo, Welt!", "detected_source_language" => "EN"}]}}
```

Get usage statistics:

```elixir
iex> Deepl.usage()
{:ok, %{"character_count" => 2345, "character_limit" => 1250000}}
```

List supported languages:

```elixir
iex> Deepl.languages(:target)
{:ok, [%{"language" => "DE", "name" => "German"}, ...]}
``` -->

## License

This package is licensed under the [MIT License](https://github.com/muzhawir/deepl/blob/main/LICENSE.md).

# Getting Started

[![Hex.pm](https://img.shields.io/hexpm/v/deepl)](https://hex.pm/packages/deepl)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/deepl)](https://hex.pm/packages/deepl)
[![Elixir CI](https://github.com/muzhawir/deepl/actions/workflows/build.yml/badge.svg)](https://github.com/muzhawir/deepl/actions/workflows/build.yml)

The [DeepL API](https://www.deepl.com/docs-api) provides a way for programs to send texts and
documents to DeepL's servers and receive high-quality translations and text improvements. This
enables developers to build a wide range of translation tools using DeepL's leading translation technology.

`deepl` is a **community-maintained** Elixir package for integrating with the DeepL API.

## Requirements

- Erlang: `27.0` or newer
- Elixir: `1.18.0-otp-27` or newer

## Installation

Add `deepl` to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:deepl, "~> 0.2.0"}
  ]
end
```

Then fetch dependencies:

```sh
mix deps.get
```

## Authentication

Get your authentication key from the [API Keys section](https://www.deepl.com/en/your-account/keys) of your DeepL account. Free tier allows up to 500,000 characters per month.

Set the key in your config:

```elixir
# config/config.exs
config :deepl, api_key: "your-api-key"
```

Or set it at runtime:

```elixir
iex> Deepl.set_api_key("your-api-key")
:ok
```

## Usage

See the [API Reference](https://hexdocs.pm/deepl/api-reference.html) for full examples.
Here are some basics:

**Translate text:**

```elixir
iex> Deepl.Translator.translate("Hello World", "ID")
{:ok,
 %{
   "translations" => [
     %{
        "detected_source_language" => "EN",
        "text" => "Halo Dunia"
      }
    ]
 }}
```

**Rephrase text:**

```elixir
iex> Deepl.Writer.rephrase("this is a example sentence to imprve", "en-US")
{:ok,
 %{
   "improvements" => [
     %{
       "detected_source_language" => "en",
       "target_language" => "en-US",
       "text" => "This is a sample sentence to improve"
     }
   ]
 }}
```

**Get usage and quota:**

```elixir
iex> Deepl.Usage.get()
{:ok,
 %{
   "character_count": 100,
   "character_limit": 500000
 }}
```

## License

Licensed under the [MIT License](https://github.com/muzhawir/deepl/blob/main/LICENSE.md).

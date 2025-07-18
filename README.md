
# DeepL

> [!WARNING]
> This package is under heavy development and considered alpha. APIs and features may change
without notice.

[![Hex.pm](https://img.shields.io/hexpm/v/deepl)](https://hex.pm/packages/deepl)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/deepl)](https://hex.pm/packages/deepl)

The [DeepL API](https://www.deepl.com/docs-api) is a language AI API that allows other computer
programs to send texts and documents to DeepL's servers and receive high-quality translations and improvements to the text. This opens a whole universe of opportunities for developers: any
translation product you can imagine can now be built on top of DeepL's best-in-class translation technology.

The `deepl` Elixir package is a **community-maintained** library that offers a convenient way for
Elixir applications to interact with the DeepL API.

## Requirements

- Elixir 1.18 or later
- Erlang/OTP 27 or later

## Installation

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
[API Keys section](https://www.deepl.com/en/your-account/keys) of your DeepL account.

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
```

## License

This package is licensed under the [MIT License](https://github.com/muzhawir/deepl/blob/main/LICENSE.md).

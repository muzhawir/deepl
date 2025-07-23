# Getting Started

[![Hex.pm](https://img.shields.io/hexpm/v/deepl)](https://hex.pm/packages/deepl)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/deepl)](https://hex.pm/packages/deepl)

The [DeepL API](https://www.deepl.com/docs-api) provides a way for programs to send texts and
documents to DeepL's servers and receive high-quality translations and text improvements. This
enables developers to build a wide range of translation tools using DeepL's leading translation technology.

`deepl` is a **community-maintained** Elixir package for integrating with the DeepL API.

## Requirements

To use `deepl`, your environment must meet these requirements:

- **Erlang**: Version `27.0` or later
- **Elixir**: Version `1.18.0-otp-27` or later

## Installation

Add `deepl` to the dependencies in your `mix.exs` file:

```elixir
def deps do
  [
    {:deepl, "~> 0.1.1"}
  ]
end
```

Fetch the dependencies by running:

```sh
mix deps.get
```

## Authentication

To use the API, you need an authentication key, which you can find in the
[API Keys section](https://www.deepl.com/en/your-account/keys) of your DeepL account. You can translate up to 500,000 characters per month for free.

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
iex> Deepl.Text.translate("Hello World", "ID")
{:ok,
 %{
   "translations" => [
     %{"detected_source_language" => "EN", "text" => "Halo Dunia"}
   ]
 }}

iex> Deepl.Text.translate(["Hello World", "Hello Developer"], "ID")
{:ok,
 %{
   "translations" => [
     %{"detected_source_language" => "EN", "text" => "Halo Dunia"},
     %{"detected_source_language" => "EN", "text" => "Halo Pengembang"}
   ]
 }}

iex> Deepl.Text.translate("Hello World", "ID", show_billed_characters: true)
{:ok,
 %{
   "translations" => [
     %{
       "billed_characters" => 11,
       "detected_source_language" => "EN",
       "text" => "Halo Dunia"
     }
   ]
 }}
```

## License

This package is licensed under the [MIT License](https://github.com/muzhawir/deepl/blob/main/LICENSE.md).

<p align="center">
  <a href="https://hexdocs.pm/deepl" target="_blank">
    <img src="./priv/assets/logo/readme-logo.png" width="150" alt="Logo">
  </a>
</p>

# DeepL

[![Hex.pm](https://img.shields.io/hexpm/v/deepl)](https://hex.pm/packages/deepl)
[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/deepl)](https://hex.pm/packages/deepl)
[![Elixir CI](https://github.com/muzhawir/deepl/actions/workflows/build.yml/badge.svg)](https://github.com/muzhawir/deepl/actions/workflows/build.yml)

The [DeepL API](https://www.deepl.com/docs-api) provides a way for programs to send texts and
documents to DeepL's servers and receive high-quality translations and text improvements. This
enables Elixir developers to build a wide range of translation tools using DeepL's leading translation technology.

`deepl` is a **community-maintained** Elixir package for integrating with the DeepL API.

## Requirements

To use `deepl`, your environment must meet these requirements:

- **Erlang**: Version `27.0` or later
- **Elixir**: Version `1.18.0-otp-27` or later

## Installation

To install `deepl`, follow the instructions in the
[Getting Started Guide](https://hexdocs.pm/deepl/getting-started.html).

## Usage

Translate a text:

```elixir
iex> Deepl.Text.translate("Hello World", "ID")

```

## License

This package is licensed under the [MIT License](https://github.com/muzhawir/deepl/blob/main/LICENSE.md).

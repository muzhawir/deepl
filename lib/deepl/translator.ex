defmodule Deepl.Translator do
  @moduledoc """
  Translates the given text to the target language.
  """
  @moduledoc since: "0.1.0"

  alias Deepl.HTTPHelper
  alias Deepl.Translator.TranslateRequest

  @type text :: binary() | list(binary())

  @doc """
  Translates a single or multiple texts to the specified target language.

  The `text` parameter can be a single string or a list of strings.

  ## Examples

      iex> Deepl.Translator.translate("Hello World", "ID")
      {:ok,
       %{
         "translations" => [
           %{"detected_source_language" => "EN", "text" => "Halo Dunia"}
         ]
       }}

      iex> Deepl.Translator.translate(
      ...>  ["Hello World", "Hello Developer"], "ID", show_billed_characters: true
      ...> )
      {:ok,
       %{
         "translations" => [
           %{
             "billed_characters" => 11,
             "detected_source_language" => "EN",
             "text" => "Halo Dunia"
           },
           %{
             "billed_characters" => 15,
             "detected_source_language" => "EN",
             "text" => "Halo Pengembang"
           }
         ]
       }}

  """
  @spec translate(text(), String.t(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def translate(text, target_lang, opts \\ [])

  def translate(text, target_lang, opts) when is_binary(text) do
    response = TranslateRequest.post_translate(text, target_lang, opts)

    HTTPHelper.response(response.status, response.body)
  end

  def translate(text, target_lang, opts) when is_list(text) do
    case Enum.count(text) do
      count when count > 0 and count <= 50 ->
        response = TranslateRequest.post_translate(text, target_lang, opts)

        HTTPHelper.response(response.status, response.body)

      0 ->
        {:error, "Text list cannot be empty"}

      _ ->
        {:error, "Text list cannot exceed 50 items"}
    end
  end

  @doc """
  Translates a single or multiple texts to the specified target language.

  This function like `translate/3`, but raises an error if the translation fails.
  """
  @spec translate!(text(), String.t(), Keyword.t()) :: map()
  def translate!(text, target_lang, opts \\ [])

  def translate!(text, target_lang, opts) when is_binary(text) do
    response = TranslateRequest.post_translate(text, target_lang, opts)

    HTTPHelper.response!(response.status, response.body)
  end

  def translate!(text, target_lang, opts) when is_list(text) do
    case Enum.count(text) do
      count when count > 0 and count <= 50 ->
        response = TranslateRequest.post_translate(text, target_lang, opts)

        HTTPHelper.response!(response.status, response.body)

      0 ->
        raise ArgumentError, "Text list cannot be empty"

      _ ->
        raise ArgumentError, "Text list cannot exceed 50 items"
    end
  end
end

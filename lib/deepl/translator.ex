defmodule Deepl.Translator do
  @moduledoc """
  Provides functions to translate text.

  API references for this module can be found in the Translate text
  [documentation](https://developers.deepl.com/api-reference/translate), please
  refer to the documentation for more information, especially options parameters detail usage in
  `translate/3` or `translate!/3`.
  """
  @moduledoc since: "0.1.0"

  alias Deepl.HTTPHelper
  alias Deepl.Translator.TranslateRequest

  @type text :: binary() | list(binary())

  @doc """
  Translates the given text to the specified target language.

  The `text` parameter can be a single string or a list of strings, and the `target_lang`
  parameter specifies the language the text should be translated to, available languages can be
  found in the translation target languages
  [documentation](https://developers.deepl.com/docs/getting-started/supported-languages#translation-target-languages).

  ## Options

  The accepted options are:

  - `context` - Add additional context that can influence a translation but is not translated
    itself, the value must be a string.
  - `model_type` - Specifies which DeepL model should be used for translation, the value must be
    a string.
  - `split_sentences` - Sets whether the translation engine should first split the input into
    sentences, the value must be a string.
  - `preserve_formatting` - Sets whether the translation engine should respect the original
    formatting, even if it would usually correct some aspects, the value must be a boolean.
  - `formality` - Sets whether the translated text should lean towards formal or informal
    language, the value must be a string.
  - `glossary_id` - Specify the glossary to use for the translation, this option requires the
    `source_lang` option to be set, the value must be a string.
  - `show_billed_characters` - Show the number of billed characters in the response, the value
    must be a boolean.
  - `tag_handling` - Sets which kind of tags should be handled, the value must be a string.
  - `outline_detection` - Set the automatic detection of XML structure, the value must be a
    boolean.
  - `non_splitting_tags` - Set the XML tags that should not be split, the value must be a list of
    strings.
  - `splitting_tags` - Set the XML tags that always cause splits, the value must be a list of
    strings.
  - `ignore_tags` - Set the XML tags that you do not want to be translated, the value must be a
    list of strings.

  The values for `model_type` can be:

  - `latency_optimized`, `quality_optimized`, `prefer_quality_optimized`

  The value for `split_sentences` can be:

  - `"0"`, `"1"`, `"nonewlines"`

  The values for `formality` can be:

  - `default`, `more`, `less`, `prefer_more`, `prefer_less`

  The values for `tag_handling` can be:

  - `xml` or `html`

  ## Examples

      iex> Deepl.Translator.translate("Hello World", "ID")
      {:ok,
       %{
         "translations" => [
           %{"detected_source_language" => "EN", "text" => "Halo Dunia"}
         ]
       }}

      iex> Deepl.Translator.translate(["Hello World", "Hello Developer"], "ID", show_billed_characters: true)
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

  This function behaves like `translate/3`, but raises an error if the translation fails.
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

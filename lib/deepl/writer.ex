defmodule Deepl.Writer do
  @moduledoc """
  > #### DeepL API Pro Subscription {: .info}
  >
  > **DeepL API for Write** requires a Pro subscription, ensure you use Pro API key for using
  > functions in this module.

  Provides functions to rephrase text.
  """
  @moduledoc since: "0.2.0"

  alias Deepl.HTTPHelper
  alias Deepl.Writer.RephraseRequest

  @type text :: binary() | list(binary())

  @doc """
  Rephrases the given text to the target language.

  The `text` parameter can be a single string or a list of strings.

  ## Examples

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

      iex> Deepl.Writer.rephrase(
      ...>  ["this is a example sentence to imprve", "this exmaple too"],
      ...>  "en-US",
      ...>  writing_style: "casual"
      ...> )
      {:ok,
       %{
         "improvements" => [
           %{
             "detected_source_language" => "en",
             "target_language" => "en-US",
             "text" => "Here's an example sentence that could be improved:"
           },
           %{
             "detected_source_language" => "en",
             "target_language" => "en-US",
             "text" => "Here's another example to consider."
           }
         ]
       }}

  """
  @spec rephrase(text(), String.t(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def rephrase(text, target_lang, opts \\ []) when is_binary(text) or is_list(text) do
    response = RephraseRequest.post_rephrase(text, target_lang, opts)

    HTTPHelper.response(response.status, response.body)
  end

  @doc """
  Rephrases the given text to the target language.

  This function behaves like `rephrase/3`, but raises an error if the rephrasing fails.
  """
  @spec rephrase!(text(), String.t(), Keyword.t()) :: map()
  def rephrase!(text, target_lang, opts \\ []) when is_binary(text) or is_list(text) do
    response = RephraseRequest.post_rephrase(text, target_lang, opts)

    HTTPHelper.response!(response.status, response.body)
  end
end

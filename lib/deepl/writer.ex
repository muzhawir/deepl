defmodule Deepl.Writer do
  @moduledoc """
  Provides functions to rephrase text.

  API references for this module can be found in the
  [Improve text documentation](https://developers.deepl.com/api-reference/improve-text).

  > #### DeepL API Pro Subscription {: .info}
  >
  > **DeepL API for Write** requires a Pro subscription. Ensure you use a Pro API key to access
  > the functions in this module.
  """
  @moduledoc since: "0.2.0"

  alias Deepl.HTTPHelper
  alias Deepl.Writer.RephraseRequest

  @type text :: binary() | list(binary())

  @doc """
  Rephrases the given text to the target language.

  The `text` parameter can be a single string or a list of strings, and the `target_lang`
  parameter available languages can be found in the Improve text
  [documentation](https://developers.deepl.com/api-reference/improve-text#param-target-lang).

  ## Options

  The accepted options are:

  - `writing_style` - Changes the writing style of your improvements, the value must be a string.
  - `tone` - Changes the tone of your improvements, the value must be a string.

  > #### Using `writing_style` and `tone` {: .error}
  >
  > It’s not possible to include both `writing_style` and `tone` in a request; only one or the
  > other can be included, if you include both, the response will be an error.

  The values for `writing_style` can be:

  - `simple`, `business`, `academic`, `casual`, `default`, `prefer_simple`, `prefer_business`,
    `prefer_academic`, `prefer_casual`.

  The values for `tone` can be:

  - `friendly`, `enthusiastic`, `confident`, `diplomatic`, `default`, `prefer_enthusiastic`,
    `prefer_friendly`, `prefer_confident`, `prefer_diplomatic`.

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

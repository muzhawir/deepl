defmodule Deepl.Language do
  @moduledoc """
  Provides functions to get the list of supported languages.

  API references for this module can be found in the Retrieve languages
  [documentation](https://developers.deepl.com/api-reference/languages).
  """
  @moduledoc since: "0.3.0"

  alias Deepl.HTTPHelper
  alias Req.Request

  @doc """
  Get the list of supported languages.

  Returns a list of supported languages, either source languages or target languages.

  ## Options

  The accepted options are:

  - `:type` - The type of languages to retrieve, either `"source"` or `"target"`, defaults to
    `"source"`.

  ## Examples

      iex> Deepl.Language.get_languages()
      {:ok,
       [
         %{"language" => "AR", "name" => "Arabic"},
         %{"language" => "BG", "name" => "Bulgarian"}
       ]}

      iex> Deepl.Language.get_languages(type: "target")
      {:ok,
       [
         %{"language" => "AR", "name" => "Arabic", "supports_formality" => false},
         %{"language" => "BG", "name" => "Bulgarian", "supports_formality" => false}
       ]}

  """
  @spec get_languages(Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def get_languages(opts \\ []) do
    {_request, response} =
      [
        method: :get,
        url: Deepl.base_url!() <> "/v2/languages?type=" <> Keyword.get(opts, :type, "source"),
        headers: HTTPHelper.required_request_headers()
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    HTTPHelper.response(response.status, response.body)
  end
end

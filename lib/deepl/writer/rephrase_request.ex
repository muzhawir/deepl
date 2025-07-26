defmodule Deepl.Writer.RephraseRequest do
  @moduledoc false
  @moduledoc since: "0.1.3"

  import Deepl.HTTPHelper, only: [required_request_headers: 0]

  alias Deepl.HTTPHelper
  alias Req.Request

  @type text :: binary() | list(binary())

  defstruct text: nil, target_lang: nil, writing_style: nil, tone: nil

  @doc """
  Sends a translation request to the DeepL API.

  Constructs a request to translate the provided text into the specified target language.
  """
  @spec post_rephrase(text(), String.t(), Keyword.t()) :: Req.Response.t() | Exception.t()
  def post_rephrase(text, target_lang, opts \\ []) do
    body =
      opts
      |> HTTPHelper.filter_keyword_by_struct_keys(%__MODULE__{})
      |> Map.put(:text, List.flatten([text]))
      |> Map.put(:target_lang, target_lang)
      |> Map.reject(fn {_k, v} -> is_nil(v) or v == [] end)
      |> JSON.encode!()

    {_request, response} =
      [
        method: :post,
        url: Deepl.base_url!() <> "/v2/write/rephrase",
        headers: required_request_headers(),
        body: body
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    response
  end
end

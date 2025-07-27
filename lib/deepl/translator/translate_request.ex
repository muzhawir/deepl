defmodule Deepl.Translator.TranslateRequest do
  @moduledoc false
  @moduledoc since: "0.1.0"

  import Deepl.HTTPHelper, only: [required_request_headers: 0]

  alias Deepl.HTTPHelper
  alias Req.Request

  @type text :: binary() | list(binary())

  defstruct text: nil,
            target_lang: nil,
            source_lang: nil,
            context: nil,
            show_billed_characters: nil,
            split_sentences: nil,
            preserve_formatting: nil,
            formality: nil,
            model_type: nil,
            glossary_id: nil,
            tag_handling: nil,
            outline_detection: nil,
            non_splitting_tags: [],
            splitting_tags: [],
            ignore_tags: []

  @doc """
  Sends a translation request to the DeepL API.

  Constructs a request to translate the provided text into the specified target language.
  """
  @spec post_translate(text(), binary(), Keyword.t()) :: Req.Response.t() | Exception.t()
  def post_translate(text, target_lang, opts \\ []) do
    body =
      opts
      |> HTTPHelper.create_map_from_keyword(%__MODULE__{})
      |> Map.put(:text, List.flatten([text]))
      |> Map.put(:target_lang, target_lang)
      |> Map.reject(fn {_key, val} -> is_nil(val) or val == [] end)
      |> JSON.encode!()

    {_request, response} =
      [
        method: :post,
        url: Deepl.base_url!() <> "/v2/translate",
        headers: required_request_headers(),
        body: body
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    response
  end
end

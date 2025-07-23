defmodule Deepl.Text.HTTPRequest do
  @moduledoc false
  @moduledoc since: "0.1.0"

  import Deepl.HTTPHelper, only: [required_request_header: 0]

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

  @translate_url Deepl.base_url!() <> "/v2/translate"

  @doc """
  Sends a translation request to the DeepL API.

  Constructs a request to translate the provided text into the specified target language.
  """
  @spec post_translate(text(), binary(), Keyword.t()) :: Req.Response.t() | Exception.t()
  def post_translate(text, target_lang, opts \\ []) do
    body =
      %__MODULE__{}
      |> struct!(create_body_content(text, target_lang, opts))
      |> Map.from_struct()
      |> Map.reject(fn {_k, v} -> is_nil(v) or v == [] end)
      |> JSON.encode!()

    {_request, response} =
      [
        method: :post,
        url: @translate_url,
        headers: [{"Content-Type", "application/json"}] ++ required_request_header(),
        body: body
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    response
  end

  @doc """
  Creates the body content for the translation post request.

  Prepares the request body based on the provided text, target language, and optional data from
  the struct.
  """
  @spec create_body_content(text(), binary(), Keyword.t()) :: map()
  def create_body_content(text, target_lang, opts \\ []) do
    opts
    |> Keyword.filter(fn {k, _v} -> k in Map.keys(%__MODULE__{}) end)
    |> Keyword.put(:text, List.flatten([text]))
    |> Keyword.put(:target_lang, target_lang)
    |> Map.new()
  end
end

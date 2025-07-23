defmodule Deepl.Text do
  @moduledoc """
  Module for translating text using the DeepL API.
  """
  @moduledoc since: "0.1.0"

  import Deepl.HTTPHelper, only: [required_request_header: 0, response: 2]

  alias Req.Request

  @type text :: binary() | list(binary())

  @translate_url Deepl.base_url!() <> "/v2/translate"

  @doc """
  Translates a single or multiple texts to the specified target language.

  The `text` parameter can be a single string or a list of strings.

  ## Examples

      iex> Deepl.Text.translate("Hello World", "ID")
      {:ok,
        %{
          "translations" => [
            %{"detected_source_language" => "EN", "text" => "Halo Dunia"}
          ]
        }
      }

      iex> Deepl.Text.translate(["Hello World", "Hello Developer"], "ID")
      {:ok,
        %{
          "translations" => [
            %{"detected_source_language" => "EN", "text" => "Halo Dunia"},
            %{"detected_source_language" => "EN", "text" => "Halo Pengembang"}
          ]
        }
      }

  """
  @spec translate(text(), binary(), Keyword.t()) :: {:ok, map()} | {:error, String.t()}
  def translate(text, target_lang, options \\ []) when is_binary(text) do
    {_request, response} =
      [
        method: :post,
        url: @translate_url,
        headers: [{"Content-Type", "application/json"}] ++ required_request_header(),
        body:
          JSON.encode!(%{
            text: List.flatten([text]),
            target_lang: target_lang
          })
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    response(response.status, response.body)
  end
end

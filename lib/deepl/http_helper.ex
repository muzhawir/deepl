defmodule Deepl.HTTPHelper do
  @moduledoc false
  @moduledoc since: "0.1.0"

  @doc """
  Returns the required headers for a DeepL API request.
  """
  @spec required_request_headers(Keyword.t()) :: list(tuple())
  def required_request_headers(opts \\ []) do
    [
      {"Accept", Keyword.get(opts, :accept, "application/json")},
      {"Authorization", "DeepL-Auth-Key " <> Deepl.get_api_key()},
      {"Content-Type", Keyword.get(opts, :content_type, "application/json")}
    ]
  end

  @doc """
  Filters keywords by the keys of a given struct.

  This function ensures that only valid options for the struct are included in the final map
  before sending a request to the DeepL API.
  """
  @spec filter_keyword_by_struct_keys(Keyword.t(), struct()) :: map()
  def filter_keyword_by_struct_keys(keyword, struct) do
    keyword
    |> Keyword.filter(fn {k, _v} -> k in Map.keys(struct) end)
    |> Map.new()
  end

  @doc """
  Handles the response from the DeepL API.

  It decodes the JSON body and returns a tuple with the status and decoded body.
  """
  @spec response(non_neg_integer(), binary()) :: {:ok, map()} | {:error, String.t()}
  def response(status, body) when is_number(status) and is_binary(body) do
    case status do
      200 ->
        {:ok, JSON.decode!(body)}

      status when status in 400..599 ->
        {:error, "[#{status}] " <> JSON.decode!(body)["message"]}

      _ ->
        {:error, "Unexpected response status: #{status}"}
    end
  end

  @doc """
  Handles the response from the DeepL API.

  This function behaves like `response/2`, but raises an exception if the response is not
  successful.
  """
  @spec response!(non_neg_integer(), binary()) :: map() | Exception.t()
  def response!(status, body) do
    case response(status, body) do
      {:ok, data} -> data
      {:error, reason} -> raise "HTTP Error: #{reason}"
    end
  end
end

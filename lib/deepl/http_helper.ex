defmodule Deepl.HTTPHelper do
  @moduledoc false
  @moduledoc since: "0.1.0"

  @doc """
  Returns the required headers for Deepl API requests.
  """
  @spec required_request_header(Keyword.t()) :: list(tuple())
  def required_request_header(opts \\ []) do
    [
      {"Accept", Keyword.get(opts, :accept, "application/json")},
      {"Authorization", "DeepL-Auth-Key " <> Deepl.get_api_key()}
    ]
  end

  @doc """
  Create optional body from keyword list.

  Filters the keyword list to include only keys that are present in the struct and returns a map.
  """
  @spec create_optional_body_content(Keyword.t(), struct()) :: map()
  def create_optional_body_content(keyword, struct) do
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

  It decodes the JSON body and returns the decoded body on success, or raises an exception on
  error.
  """
  @spec response!(non_neg_integer(), binary()) :: map() | Exception.t()
  def response!(status, body) do
    case response(status, body) do
      {:ok, data} -> data
      {:error, reason} -> raise "HTTP Error: #{reason}"
    end
  end
end

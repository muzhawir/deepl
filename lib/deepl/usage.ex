defmodule Deepl.Usage do
  @moduledoc """
  Module for retrieving usage and quota for the current billing period with the DeepL API.

  For more information, refer to the retrieve usage and quota
  [documentation](https://developers.deepl.com/api-reference/usage-and-quota).
  """
  @moduledoc since: "0.0.1"

  import Deepl.HTTPHelper, only: [required_request_header: 0, response: 2]

  alias Req.Request

  @doc """
  Retrieve current usage and quota information.

  ## Examples

      # This is an example output for Free plan
      iex> Deepl.Usage.get()
      {:ok,
       %{
         "character_count": 100,
         "character_limit": 500000
       }}

      # This is an example output for Pro plan
      iex> Deepl.Usage.get()
      {:ok,
       %{
         "api_key_character_count" => 3000,
         "api_key_character_limit" => 1000000000000,
         "character_count" => 3000,
         "character_limit" => 1000000000000,
         "end_time" => "2025-06-30T00:12:32Z",
         "products" => [
           %{
             "api_key_character_count" => 1000,
             "character_count" => 1000,
             "product_type" => "write"
           },
           %{
             "api_key_character_count" => 2000,
             "character_count" => 2000,
             "product_type" => "translate"
           }
         ],
         "start_time" => "2025-05-30T00:12:32Z"
       }}

  """
  @spec get() :: {:ok, map()} | {:error, String.t()}
  def get do
    {_request, response} =
      [
        method: :get,
        url: Deepl.base_url!() <> "/v2/usage",
        headers: required_request_header()
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    response(response.status, response.body)
  end
end

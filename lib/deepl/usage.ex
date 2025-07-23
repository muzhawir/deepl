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

      iex> Deepl.Usage.get()
      %{"character_count": 100, "character_limit": 500000}

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

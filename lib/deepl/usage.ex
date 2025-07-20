defmodule Deepl.Usage do
  @moduledoc """
  Module for retrieving usage and quota for the current billing period with the DeepL API.

  For more information, refer to the retrieve usage and quota
  [documentation](https://developers.deepl.com/api-reference/usage-and-quota).
  """
  @moduledoc since: "0.0.1"

  import Deepl.HTTPHelper, only: [required_request_header: 0]

  alias Req.Request

  @base_url Deepl.base_url!() <> "/v2/usage"

  @doc """
  Retrieve current usage and quota information.

  ## Examples

      iex> Deepl.Usage.get()
      %{"character_count": 100, "character_limit": 500000}

  """
  @spec get() :: map()
  def get do
    {_request, response} =
      [
        method: :get,
        url: @base_url,
        headers: required_request_header()
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    JSON.decode!(response.body)
  end
end

defmodule Deepl.Usage do
  @moduledoc """
  Module for retrieving usage and quota for the current billing period with the DeepL API.

  For more information, refer to the retrieve usage and quota
  [documentation](https://developers.deepl.com/api-reference/usage-and-quota).
  """

  alias Req.Request

  @base_url Deepl.base_url!() <> "/usage"

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
        headers: [
          {"Accept", "application/json"},
          {"Authorization", "DeepL-Auth-Key " <> Deepl.get_api_key()}
        ]
      ]
      |> Request.new()
      |> Deepl.Request.run_request()

    JSON.decode!(response.body)
  end
end

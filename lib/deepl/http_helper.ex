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
end

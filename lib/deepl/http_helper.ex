defmodule Deepl.HTTPHelper do
  @moduledoc false

  @doc """
  Returns the required headers for Deepl API requests.
  """
  @spec required_request_header(Keyword.t()) :: list()
  def required_request_header(opts \\ []) do
    accept = Keyword.get(opts, :accept, "application/json")

    [
      {"Accept", accept},
      {"Authorization", "DeepL-Auth-Key " <> Deepl.get_api_key()}
    ]
  end
end

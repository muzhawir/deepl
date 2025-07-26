defmodule Deepl.Request do
  @moduledoc false
  @moduledoc since: "0.1.0"

  @callback run_request(term()) :: {term(), Req.Response.t() | Exception.t()}

  @doc """
  Runs the request using the configured request behaviour.

  This function is used internally by the library to execute HTTP requests.
  """
  @spec run_request(term()) :: {term(), Req.Response.t() | Exception.t()}
  def run_request(request), do: implement().run_request(request)

  defp implement, do: Application.get_env(:deepl, :request_behaviour, Req.Request)
end

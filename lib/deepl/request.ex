defmodule Deepl.Request do
  @moduledoc false

  @callback run_request(term()) :: {term(), Req.Response.t() | Exception.t()}

  def run_request(request), do: implement().run_request(request)

  defp implement, do: Application.get_env(:deepl, :request_behaviour, Req.Request)
end

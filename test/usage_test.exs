defmodule UsageTest do
  use ExUnit.Case, async: true

  import Mox

  alias Deepl.Usage
  alias Req.Request
  alias Req.Response

  setup :verify_on_exit!

  describe "get/0" do
    test "returns usage information" do
      json = ~s"{\"character_count\":100,\"character_limit\":500000}"

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Request{}, %Response{body: json}}
      end)

      assert Usage.get() == JSON.decode!(json)
    end
  end
end

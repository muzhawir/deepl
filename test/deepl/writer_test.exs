defmodule Deepl.WriterTest do
  use ExUnit.Case, async: true

  import Mox

  alias Deepl.Writer

  setup :verify_on_exit!

  describe "rephrase/3" do
    test "rephrase single text" do
      response = ~s"""
      {
        "improvements": [
          {
            "text": "This is a sample sentence to improve",
            "detected_source_language": "en",
            "target_language": "en-US"
          }
        ]
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Writer.rephrase("this is a example sentence to imprve", "en-US") ==
               JSON.decode(response)
    end
  end
end

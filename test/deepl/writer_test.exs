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

    test "rephrase multiple text with options" do
      response = ~s"""
      {
        "improvements": [
         {
           "detected_source_language": "en",
           "target_language": "en-US",
           "text": "Here's an example sentence that could be improved:"
         },
         {
           "detected_source_language": "en",
           "target_language": "en-US",
           "text": "Here's another example to consider."
         }
        ]
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Writer.rephrase(
               ["this is a example sentence to imprve", "this exmaple too"],
               "en-US",
               writing_style: "casual"
             ) == JSON.decode(response)
    end

    test "return {:error, reason} on invalid input" do
      response = ~s"""
      {
        "message": "Value for 'target_lang' not supported."
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{status: 400, body: response}}
      end)

      assert Writer.rephrase("this is a example sentence to imprve", "id-ID") ==
               {:error, "[400] " <> JSON.decode!(response)["message"]}
    end
  end

  describe "rephrase!/3" do
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

      assert Writer.rephrase!("this is a example sentence to imprve", "en-US") ==
               JSON.decode!(response)
    end

    test "raise an error on invalid input" do
      response = ~s"""
      {
        "message": "Value for 'target_lang' not supported."
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{status: 400, body: response}}
      end)

      assert_raise RuntimeError, "HTTP Error: [400] " <> JSON.decode!(response)["message"], fn ->
        Writer.rephrase!("this is a example sentence to imprve", "id-ID")
      end
    end
  end
end

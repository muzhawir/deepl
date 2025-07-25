defmodule Deepl.TranslatorTest do
  use ExUnit.Case, async: true

  import Mox

  alias Deepl.Translator

  setup :verify_on_exit!

  describe "translate/3" do
    test "translate single text" do
      response = ~s"""
      {"translations":[{"detected_source_language":"EN","text":"Halo Dunia"}]}
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Translator.translate("Hello World", "ID") == JSON.decode(response)
    end

    test "translate multiple text" do
      response = ~s"""
      {
        "translations":[
          {"detected_source_language":"EN","text":"Halo Dunia"},
          {"detected_source_language":"EN","text":"Halo Pengembang"}
        ]
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Translator.translate(["Hello World", "Hello Developer"], "ID") ==
               JSON.decode(response)
    end

    test "translate text with optional options" do
      response = ~s"""
      {
        "translations": [
          {
            "billed_characters": 11,
            "detected_source_language": "EN",
            "text": "Halo Dunia"
          }
        ]
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Translator.translate("Hello World", "ID", show_billed_characters: true) ==
               JSON.decode(response)
    end

    test "return {:error, reason} on invalid input" do
      response = ~s({"message": "Value for 'target_lang' not supported."})

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{status: 400, body: response}}
      end)

      assert Translator.translate("Hello World", "IDS") ==
               {:error, "[400] " <> JSON.decode!(response)["message"]}
    end
  end

  describe "translate!/3" do
    test "translate single text" do
      response = ~s"""
      {"translations":[{"detected_source_language":"EN","text":"Halo Dunia"}]}
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Translator.translate!("Hello World", "ID") == JSON.decode!(response)
    end

    test "raise an error on invalid input" do
      response = ~s({"message": "Value for 'target_lang' not supported."})

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{status: 400, body: response}}
      end)

      assert_raise RuntimeError, "HTTP Error: [400] " <> JSON.decode!(response)["message"], fn ->
        Translator.translate!("Hello World", "IDS")
      end
    end
  end
end

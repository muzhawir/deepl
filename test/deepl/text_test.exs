defmodule Deepl.TextTest do
  use ExUnit.Case, async: true

  import Mox

  alias Deepl.Text

  setup :verify_on_exit!

  describe "translate/2" do
    test "translate single text" do
      response = ~s"""
      {"translations":[{"detected_source_language":"EN","text":"Halo Dunia"}]}
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Text.translate("Hello World", "ID") == JSON.decode(response)
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

      assert Text.translate(["Hello World", "Hello Developer"], "ID") ==
               JSON.decode(response)
    end

    test "translate text with optional options" do
      response = ~s"""
      {
        "translations": [
          {
            "detected_source_language":"EN",
            "text":"Hallo, Welt",
            "billed_characters":12,
            "model_type_used":"quality_optimized"
          }
        ]
      }
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      options = [
        source_lang: "EN",
        context: nil,
        show_billed_characters: false,
        split_sentences: 1,
        preserve_formatting: false,
        formality: "default",
        model_type: nil,
        glossary_id: nil,
        tag_handling: nil,
        outline_detection: nil,
        non_splitting_tags: [],
        splitting_tags: [],
        ignore_tags: []
      ]

      assert Text.translate("Hello World", "DE", options) == JSON.decode(response)
    end
  end
end

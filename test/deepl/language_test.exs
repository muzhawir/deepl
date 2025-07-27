defmodule Deepl.LanguageTest do
  use ExUnit.Case, async: true

  import Mox

  alias Deepl.Language

  setup :verify_on_exit!

  describe "get_languages/1" do
    test "get source supported languages" do
      response = ~s"""
      [
        {"language": "AR", "name": "Arabic"},
        {"language": "BG", "name": "Bulgarian"}
      ]
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Language.get_languages() == JSON.decode(response)
    end

    test "get target supported languages" do
      response = ~s"""
      [
        {"language": "AR", "name": "Arabic", "supports_formality": false},
        {"language": "BG", "name": "Bulgarian", "supports_formality": false}
      ]
      """

      expect(Deepl.MockRequest, :run_request, fn _request ->
        {%Req.Request{}, %Req.Response{body: response}}
      end)

      assert Language.get_languages(type: "target") == JSON.decode(response)
    end
  end
end

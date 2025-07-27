defmodule Deepl.HTTPHelperTest do
  use ExUnit.Case, async: true

  alias Deepl.HTTPHelper

  describe "required_request_headers/1" do
    test "Return required header list" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")

      assert HTTPHelper.required_request_headers() == [
               {"Accept", "application/json"},
               {"Authorization", "DeepL-Auth-Key wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx"}
             ]
    end

    test "Return required header list with custom accept header" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")

      assert HTTPHelper.required_request_headers(accept: "text/plain") == [
               {"Accept", "text/plain"},
               {"Authorization", "DeepL-Auth-Key wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx"}
             ]
    end
  end
end

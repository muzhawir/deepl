defmodule Deepl.HTTPHelperTest do
  use ExUnit.Case, async: true

  alias Deepl.HTTPHelper

  describe "required_request_header/1" do
    test "Return required header list" do
      assert HTTPHelper.required_request_header() == [
               {"Accept", "application/json"},
               {"Authorization", "DeepL-Auth-Key test:fx"}
             ]
    end

    test "Return required header list with custom accept header" do
      assert HTTPHelper.required_request_header(accept: "text/plain") == [
               {"Accept", "text/plain"},
               {"Authorization", "DeepL-Auth-Key test:fx"}
             ]
    end
  end
end

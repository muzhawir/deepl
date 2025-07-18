defmodule UsageTest do
  use ExUnit.Case, async: true

  alias Deepl.Usage

  describe "get/0" do
    test "returns the usage information" do
      usage = Usage.get()

      assert is_map(usage)

      case Deepl.plan!() do
        :free ->
          Enum.each(["character_count", "character_limit"], fn key ->
            assert Map.has_key?(usage, key)
          end)

        :pro ->
          Enum.each(["character_count", "character_limit", "products"], fn key ->
            assert Map.has_key?(usage, key)
          end)
      end
    end
  end
end

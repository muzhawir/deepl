defmodule DeeplTest do
  use ExUnit.Case

  describe "get_api_key/0" do
    test "returns the API key from the application environment" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")

      assert Deepl.get_api_key() == "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx"
    end

    test "returns nil if the API key is not set" do
      Application.delete_env(:deepl, :api_key)

      assert Deepl.get_api_key() == nil
    end
  end

  describe "set_api_key/1" do
    test "sets the API key in the application environment" do
      assert Deepl.set_api_key("wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx") == :ok
    end
  end

  describe "plan!/0" do
    test "returns :free for free plan API key" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")

      assert Deepl.plan!() == :free
    end

    test "returns :pro for pro plan API key" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012")

      assert Deepl.plan!() == :pro
    end

    test "raises an error if the API key is not set" do
      Application.delete_env(:deepl, :api_key)

      assert_raise RuntimeError, fn -> Deepl.plan!() end
    end
  end

  describe "base_url!/0" do
    test "returns the base URL for the free plan" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")

      assert Deepl.base_url!() == "https://api-free.deepl.com"
    end

    test "returns the base URL for the pro plan" do
      Application.put_env(:deepl, :api_key, "wwwwwwww-xxxx-yyyy-zzzz-123456789012")

      assert Deepl.base_url!() == "https://api.deepl.com"
    end

    test "raises an error if the API key is not set" do
      Application.delete_env(:deepl, :api_key)

      assert_raise RuntimeError, fn -> Deepl.base_url!() end
    end
  end
end

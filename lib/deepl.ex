defmodule Deepl do
  @moduledoc """
  Provide base functions for the DeepL API.
  """
  @moduledoc since: "0.1.0"

  @doc """
  Get the currently active API key.

  ## Examples

      iex> Deepl.get_api_key()
      "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx"

  """
  @spec get_api_key() :: String.t() | nil
  def get_api_key, do: Application.get_env(:deepl, :api_key) || nil

  @doc """
  Set the API key in the application environment.

  ## Examples

      iex> Deepl.set_api_key("wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")
      :ok

  """
  @spec set_api_key(String.t()) :: :ok
  def set_api_key(key), do: Application.put_env(:deepl, :api_key, key)

  @doc """
  Get current plan based on the API key.

  Returns atom `:free` for free accounts and `:pro` for pro accounts.

  ## Examples

      iex> Deepl.plan!()
      :free

  """
  @spec plan!() :: :free | :pro | Exception.t()
  def plan! do
    key = get_api_key() || raise "API key is not set. Please set it using `Deepl.set_api_key/1`."

    if String.ends_with?(key, ":fx"), do: :free, else: :pro
  end

  @doc """
  Get base URL based on API key input.

  Returns base URL for pro or free accounts, determined by the API key, free account keys end
  with `:fx`.

  ## Examples

      iex> Deepl.base_url!()
      "https://api-free.deepl.com"

  """
  @spec base_url!() :: String.t()
  def base_url! do
    case plan!() do
      :free -> "https://api-free.deepl.com"
      :pro -> "https://api.deepl.com"
    end
  end
end

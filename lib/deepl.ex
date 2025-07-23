defmodule Deepl do
  @moduledoc """
  An Elixir package providing a convenient interface to the [DeepL](https://www.deepl.com) API.
  """
  @moduledoc since: "0.1.0"

  @doc """
  Get the API key from the application environment.

  Retrieves the API key set in the application configuration.

  ## Examples

      iex> Deepl.get_api_key()
      "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx"

  """
  @spec get_api_key() :: String.t() | nil
  def get_api_key, do: Application.get_env(:deepl, :api_key) || nil

  @doc """
  Sets the API key for the DeepL service.

  Stores the API key string in the application environment.

  ## Examples

      iex> Deepl.set_api_key("wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")
      :ok

  """
  @spec set_api_key(String.t()) :: :ok
  def set_api_key(key), do: Application.put_env(:deepl, :api_key, key)

  @doc """
  Gets the current plan of the DeepL API based on the API key.

  Returns `:free` for free accounts and `:pro` for pro accounts.

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
  Get the base URL for the DeepL API based on the current plan.

  Returns the base URL for the DeepL API, which varies depending on whether the user has a
  free or pro plan.

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

defmodule Deepl do
  @moduledoc """
  Elixir package for the DeepL language translation API.
  """
  @moduledoc since: "0.1.0"

  @doc """
  Retrieves the API key for the DeepL service from the application environment.

  Returns `nil` and prints a warning if the API key is not set.

  ## Examples

      iex> Deepl.get_api_key()
      "wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx"

  """
  @spec get_api_key() :: String.t() | nil
  def get_api_key, do: Application.get_env(:deepl, :api_key) || warn_missing_api_key()

  defp warn_missing_api_key do
    message = """
    API Key does not exist.

    Visit https://www.deepl.com/en/your-account/keys to create one and set the API key using
    `Deepl.set_api_key/1` function.
    """

    IO.puts(IO.ANSI.yellow() <> message)
    nil
  end

  @doc """
  Sets the API key for the DeepL service.

  ## Examples

      iex> Deepl.set_api_key("wwwwwwww-xxxx-yyyy-zzzz-123456789012:fx")
      :ok

  """
  @spec set_api_key(String.t()) :: :ok
  def set_api_key(key), do: Application.put_env(:deepl, :api_key, key)

  @doc """
  Returns the current plan of the DeepL service based on the API key format.

  Raises if the API key is not set.

  ## Examples

      iex> Deepl.plan!()
      :free

  """
  @spec plan!() :: :free | :pro | Exception.t()
  def plan! do
    key = get_api_key() || raise "API key is not set. Please set it using `Deepl.set_api_key/1`."

    if String.ends_with?(key, ":fx") do
      :free
    else
      :pro
    end
  end

  @doc """
  Returns the base URL for the DeepL API based on the current plan.

  ## Examples

      iex> Deepl.base_url!()
      "https://api-free.deepl.com/v2"

  """
  @spec base_url!() :: String.t()
  def base_url! do
    case plan!() do
      :free -> "https://api-free.deepl.com/v2"
      :pro -> "https://api.deepl.com/v2"
    end
  end
end

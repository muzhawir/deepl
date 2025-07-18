import Config

if config_env() == :prod do
  config :deepl, api_key: System.fetch_env!("DEEPL_API_KEY")
end

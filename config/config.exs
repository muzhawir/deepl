import Config

# You need an authentication key to access the API.
# You can find your key in the “API Keys” tab in your account.
# (https://www.deepl.com/en/your-account/keys)

if Mix.env() in [:dev, :test] do
  config :deepl, api_key: "c5bfe33a-0487-4e37-add3:fx"
end

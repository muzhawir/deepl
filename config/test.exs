import Config

# You need an authentication key to access the API.
# You can find your key in the “API Keys” tab in your account.
# (https://www.deepl.com/en/your-account/keys)

if Mix.env() in [:dev, :test] do
  config :deepl, api_key: "test:fx"
  config :deepl, request_behaviour: Deepl.MockRequest
end

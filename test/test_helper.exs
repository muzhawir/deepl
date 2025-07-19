Mox.defmock(Deepl.MockRequest, for: Deepl.Request)
Application.put_env(:deepl, :request_behaviour, Deepl.MockRequest)

ExUnit.start()

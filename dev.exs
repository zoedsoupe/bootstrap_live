# iex -S mix dev

Logger.configure(level: :debug)

defmodule BootstrapLive.Layouts do
  use Phoenix.Component

  use Phoenix.VerifiedRoutes,
    endpoint: BootstrapLive.Server.Endpoint,
    router: BootstrapLive.Server.Router,
    statics: ~w(assets)

  import Phoenix.Controller, only: [get_csrf_token: 0]
  embed_templates("lib/bootstrap_live/layouts/*")
end

BootstrapLive.Server.start()

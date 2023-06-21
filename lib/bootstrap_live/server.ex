defmodule BootstrapLive.Server do
  @moduledoc false

  defmodule Router do
    @moduledoc false

    use Phoenix.Router
    import Phoenix.LiveView.Router

    pipeline :browser do
      plug(:fetch_session)
    end

    scope "/", BootstrapLive do
      live("/components", ComponentsLive)
    end
  end

  defmodule Endpoint do
    @moduledoc false

    use Phoenix.Endpoint, otp_app: :bootstrap_live

    socket("/live", Phoenix.LiveView.Socket)

    if code_reloading? do
      socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
      plug(Phoenix.LiveReloader)
      plug(Phoenix.CodeReloader)
    end

    plug(Plug.Static,
      at: "/",
      from: :bootstrap_live,
      gzip: false,
      only: ~w(assets)
    )

    plug(Plug.Session,
      store: :cookie,
      key: "_live_view_key",
      signing_salt: "m3w4qIJQqs5/"
    )

    plug(Plug.RequestId)

    plug(Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json],
      pass: ["*/*"],
      json_decoder: Jason
    )

    plug(Router)
  end

  def start do
    opts = [
      url: [host: "localhost"],
      secret_key_base: "AzXq19SNz189fww2R8ttyzUYAl7Nc/DPHfyc+4Ish60euk72IowtPJ3v+6uEo6Uy",
      live_view: [signing_salt: "QvGq43QXgP6UiOuypGdZfFHawTS6T8aV"],
      http: [port: System.get_env("PORT") || 4001],
      render_errors: [view: BootstrapLive.Layouts.ErrorHTML],
      reloadable_compilers: [:elixir],
      check_origin: false,
      pubsub_server: __MODULE__.PubSub,
      watchers: [
        esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
      ],
      live_reload: [
        patterns: [
          ~r"lib/bootstrap_live/live/.*(ex|heex)$",
          ~r"priv/static/.*(js|css)$"
        ]
      ]
    ]

    Application.put_env(:bootstrap_live, __MODULE__.Endpoint, opts)
    Application.put_env(:phoenix, :serve_endpoints, true)

    Task.start(fn ->
      children = [
        {Phoenix.PubSub, [name: __MODULE__.PubSub, adapter: Phoenix.PubSub.PG2]},
        __MODULE__.Endpoint
      ]

      {:ok, _} = Supervisor.start_link(children, strategy: :one_for_one)
      Process.sleep(:infinity)
    end)
  end
end

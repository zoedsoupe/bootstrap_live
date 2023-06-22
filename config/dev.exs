import Config

config :esbuild,
  version: "0.18.6",
  default: [
    args: ~w(js/app.js --bundle --platform=node --target=es2017 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :bootstrap_live, BootstrapLive.Server.Endpoint, code_reloader: true

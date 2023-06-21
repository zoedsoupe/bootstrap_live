defmodule BootstrapLive do
  @moduledoc false

  defdelegate button(assigns), to: BootstrapLive.Button, as: :render
end

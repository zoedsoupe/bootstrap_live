defmodule BootstrapLive.ComponentsLive do
  use Phoenix.LiveView, layout: {BootstrapLive.Layouts, :root}
  use Phoenix.Component

  import BootstrapLive

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.button style="primary" on-click="test">
      Hello
    </.button>
    """
  end
end

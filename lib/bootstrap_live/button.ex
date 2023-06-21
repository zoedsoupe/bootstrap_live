defmodule BootstrapLive.Button do
  @moduledoc """
  The `button` componente from bootstrap.
  Official docs:
  """

  use Phoenix.Component

  attr(:"on-click", :string, required: true)
  attr(:style, :string, values: ~w(primary secondary terciary), default: "primary")

  slot(:inner_block)

  def render(%{"on-click": on_click} = assigns) do
    assigns = assign(assigns, on_click: on_click)

    ~H"""
    <button class={"btn btn-#{@style}"} phx-click={@on_click}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end

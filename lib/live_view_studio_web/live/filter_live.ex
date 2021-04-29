defmodule LiveViewStudioWeb.FilterLive do
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Boats

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        boats: Boats.list_boats(),
        type: "",
        prices: [""]
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Front Porch Light</h1>
    <center display="flex" flex-wrap="wrap">
      <%= for boat <- @boats do %>
        <div style="">
          <img src="<%= boat.image %>" />
          <span>"<%= boat.model %>"</span>
        </div>
      <% end %>
    </center>
    """
  end

  # def handle_event("on", _, socket) do
  #   socket = assign(socket, :brightness, 100)
  #   {:noreply, socket}
  # end

  # def handle_event("up", _, socket) do
  #   socket = update(socket, :brightness, &(&1 + 10))
  #   {:noreply, socket}
  # end

  # def handle_event("down", _, socket) do
  #   socket = update(socket, :brightness, &(&1 - 10))
  #   {:noreply, socket}
  # end

  # def handle_event("off", _, socket) do
  #   socket = assign(socket, :brightness, 0)
  #   {:noreply, socket}
  # end
end

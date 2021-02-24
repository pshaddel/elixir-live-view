defmodule LiveViewStudioWeb.KeyEventsLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       images: Enum.map(0..18, &"juggling-#{&1}.jpg"),
       current: 0
     )}
  end

  def render(assigns) do
    ~L"""
    <h1>Juggling Key Events</h1>
    <div id="key-events">
      <img src="/images/juggling/<%= Enum.at(@images, @current) %>">
      <div class="status">
        <%= Enum.at(@images, @current) %>
      </div>
    </div>
    """
  end

  defp next(socket) do
    rem(
      socket.assigns.current + 1,
      Enum.count(socket.assigns.images)
    )
  end

  defp previous(socket) do
    rem(
      socket.assigns.current - 1 + Enum.count(socket.assigns.images),
      Enum.count(socket.assigns.images)
    )
  end
end

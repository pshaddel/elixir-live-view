defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :brightness, 10)}
  end

  def render(assigns) do
    ~L"""
    <h1> porch the Light </h1>
    <div id="light">
      <div class="meter">
       <span style="width: <%= assigns.brightness %>%">
       <%= assigns.brightness %>
       </span>
      </div>
      <button phx-click="off"> <img src="images/light-off.svg"/></button>
      <button phx-click="on" > <img src="images/light-on.svg"/></button>
      <button phx-click="down" > <img src="images/down.svg"/></button>
      <button phx-click="up" > <img src="images/up.svg"/></button>
    </div>
    """
  end

  def handle_event("on", _params, socket) do
    {:noreply, assign(socket, :brightness, 100)}
  end

  def handle_event("off", _params, socket) do
    {:noreply, assign(socket, :brightness, 0)}
  end

  def handle_event("down", _params, socket) do
    brightness =
      if socket.assigns.brightness - 10 >= 0 do
        socket.assigns.brightness - 10
      else
        socket.assigns.brightness
      end

    {:noreply, assign(socket, :brightness, brightness)}
  end

  def handle_event("up", _params, socket) do
    brightness =
      if socket.assigns.brightness + 10 <= 100 do
        socket.assigns.brightness + 10
      else
        socket.assigns.brightness
      end

    {:noreply, assign(socket, :brightness, brightness)}
  end
end

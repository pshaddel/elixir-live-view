defmodule LiveViewStudioWeb.FormLive do
  import Number.Currency
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Licenses

  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 2, amount: Licenses.calculate(2))
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Dynamic Form</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img src="images/license.svg"/>
            <span>
            Your License is currently for <b> <%= assigns.seats %> </b>
            </span>
          </div>
          <form phx-change="update">
          <input name="seats_value" type="range" min="1" max="10" value="<%= assigns.seats %>"/>
          </form>
          <div class="amount">
            <%= number_to_currency(assigns.amount) %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats_value" => seats}, socket) do
    socket =
      assign(socket,
        seats: String.to_integer(seats),
        amount: Licenses.calculate(String.to_integer(seats))
      )

    {:noreply, socket}
  end
end

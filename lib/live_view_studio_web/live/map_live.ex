defmodule LiveViewStudioWeb.MapLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Incidents

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        incidents: Incidents.list_incidents(),
        selected_incident: nil
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Nearby Incidents</h1>
    <div id="mapping">
      <div class="sidebar">
        <%= for incident <- @incidents do %>
          <div class="incident
                <%= if @selected_incident == incident, do: 'selected' %>"
              phx-click="select-incident"
              phx-value-id="<%= incident.id %>">
            <%= incident.description %>
          </div>
        <% end %>
      </div>
      <div class="main">
        <div id="map">
        </div>
      </div>
    </div>
    """
  end

  def handle_event("select-incident", %{"id" => id}, socket) do
    incident = find_incident(socket, String.to_integer(id))

    socket =
      socket
      |> assign(selected_incident: incident)

    {:noreply, socket}
  end

  defp find_incident(socket, id) do
    Enum.find(socket.assigns.incidents, &(&1.id == id))
  end
end

defmodule LiveViewStudioWeb.SearchLive do
  use LiveViewStudioWeb, :live_view
  alias LiveViewStudio.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        stores: [],
        zip: "",
        isLoading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Search</h1>
    <form phx-submit="search">
      <input name="zip_value" value="<%= @zip %>"/>
      <button type="submit">search</button>
    </form>
    <%= if @isLoading do %>
      <p color="red">Loading...</p>
    <% end %>
      <%= for store <- @stores do %>
      <p> name: <%= store.name %>  - zip: <%= store.zip %></p>
      <% end %>
    <div id="light">
    </div>
    """
  end

  def handle_event("search", %{"zip_value" => zip}, socket) do
    send(self(), {:search_zip, zip})

    socket =
      assign(socket,
        isLoading: true
      )

    {:noreply, socket}
  end

  def handle_info({:search_zip, zip}, socket) do
    socket =
      assign(socket,
        stores: LiveViewStudio.Stores.search_by_zip(zip),
        zip: "",
        isLoading: false
      )

    {:noreply, socket}
  end
end

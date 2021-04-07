defmodule LiveViewStudioWeb.ServerComponent do
  use LiveViewStudioWeb, :live_component

  alias LiveViewStudio.Servers

  def render(assigns) do
    ~L"""
    <div class="card">
      <div class="header">
        <h2><%= @selected_server.name %></h2>
        <button
          class="<%= @selected_server.status %>"
          phx-click="toggle-status"
          phx-value-id="<%= @selected_server.id %>"
          phx-target="<%= @myself %>"
          phx-disable-with="Saving...">
          <%= @selected_server.status %>
        </button>
      </div>
      <div class="body">
        <div class="row">
          <div class="deploys">
            <img src="/images/deploy.svg">
            <span>
              <%= @selected_server.deploy_count %> deploys
            </span>
          </div>
          <span>
            <%= @selected_server.size %> MB
          </span>
          <span>
            <%= @selected_server.framework %>
          </span>
        </div>
        <h3>Git Repo</h3>
        <div class="repo">
          <%= @selected_server.git_repo %>
        </div>
        <h3>Last Commit</h3>
        <div class="commit">
          <%= @selected_server.last_commit_id %>
        </div>
        <blockquote>
          <%= @selected_server.last_commit_message %>
        </blockquote>
      </div>
    </div>
    """
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    server = Servers.get_server!(id)

    new_status = if server.status == "up", do: "down", else: "up"

    {:ok, _server} = Servers.update_server(server, %{status: new_status})

    {:noreply, socket}
  end
end

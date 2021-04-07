defmodule LiveViewStudioWeb.ServerFormComponent do
  use LiveViewStudioWeb, :live_component

  alias LiveViewStudio.Servers
  alias LiveViewStudio.Servers.Server

  def mount(socket) do
    changeset = Servers.change_server(%Server{})

    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    ~L"""
    <h2><%= @title %></h2>

    <%= f = form_for @changeset, "#",
              phx_submit: "save",
              phx_change: "validate",
              phx_target: @myself %>
      <div class="field">
        <%= label f , :name %>
        <%= text_input f, :name,
                        autocomplete: "off",
                        phx_debounce: "2000" %>
        <%= error_tag f, :name %>
      </div>

      <div class="field">
        <%= label f, :framework %>
        <%= text_input f, :framework,
                        autocomplete: "off",
                        phx_debounce: "2000" %>
        <%= error_tag f, :framework %>
      </div>

      <div class="field">
        <%= label f, :size, "Size (MB)" %>
        <%= number_input f, :size,
                          autocomplete: "off",
                          phx_debounce: "blur" %>
        <%= error_tag f, :size %>
      </div>

      <div class="field">
        <%= label f, :git_repo, "Git Repo" %>
        <%= text_input f, :git_repo,
                          autocomplete: "off",
                          phx_debounce: "blur" %>
        <%= error_tag f, :git_repo %>
      </div>

      <%= submit "Save", phx_disable_with: "Saving..." %>

      <%= live_patch "Cancel",
            to: @return_to,
            class: "cancel" %>
      </form>
    """
  end

  def handle_event("save", %{"server" => params}, socket) do
    case Servers.create_server(params) do
      {:ok, _} ->
        socket =
          push_redirect(socket,
            to: socket.assigns.return_to
          )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"server" => params}, socket) do
    changeset =
      %Server{}
      |> Servers.change_server(params)
      |> Map.put(:action, :insert)

    socket = assign(socket, changeset: changeset)

    {:noreply, socket}
  end
end
